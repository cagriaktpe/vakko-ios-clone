//
//  CommentsView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import SwiftUI

struct CommentsView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var productsViewModel: ProductsViewModel
    
    @State private var comments: [CommentModel] = []
    
    let product: ProductModel
    
    var body: some View {
        ScrollView {
            ForEach(comments, id: \.self) { comment in
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text(comment.authorName)
                            .font(.headline)
                        Text(comment.comment)
                            .font(.subheadline)
                    }
                }
            }
            
            if comments.isEmpty {
                Text("Henüz yorum yapılmamış.")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("YORUMLAR")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .onAppear {
            comments = productsViewModel.comments.filter { $0.productId == product.productId }
        }
    }
}

#Preview {
    
    let product = ProductModel(productId: "1", thumbnail: "https://i.ibb.co/D9JYsjV/orange-forward.jpg", images: ["https://i.ibb.co/D9JYsjV/orange-forward.jpg", "https://i.ibb.co/GsmsHzN/orange-back.jpg"], title: "Turuncu Elbise", description: "Description", price: 100, sizes: ["34", "36", "38", "40", "42"], category: CategoryType.woman.rawValue, subCategory: WomanSubCategoryType.dress.rawValue, careDetail: "This is a care", exchangeDetail: "This is an exchange")
    
    return NavigationStack {
        CommentsView(product: product)
            .environmentObject(ProfileViewModel())
    }
}
