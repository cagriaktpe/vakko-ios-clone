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
            VStack(alignment: .leading) {
                ForEach(comments, id: \.self) { comment in
                    CommentRowView(comment: comment)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            

            if comments.isEmpty {
                Text("Henüz yorum yapılmamış.")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("YORUMLAR")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
        .overlay(alignment: .bottom) {
            addCommentButton
        }
        .onAppear {
//            comments = productsViewModel.comments.filter { $0.productId == product.productId }

            // for testing
            comments = CommentModel.mockArray
        }
    }
}

struct CommentRowView: View {
    let comment: CommentModel

    var body: some View {
        VStack(alignment: .leading) {
            // rating
            HStack {
                ForEach(0 ..< comment.rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }
            }
            
            HStack {
                Text(comment.authorName)
                    .font(.caption)
                Text("|")
                Text(comment.dateCreated, style: .date)
                    .font(.caption)
            }
            .foregroundStyle(.secondary)
            .padding(.bottom, 2)

            Text(comment.comment)
                .font(.caption)

        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        
    }
}

extension CommentsView {
    var addCommentButton: some View {
        Button {
            
        } label: {
            Label("Yorum Yap", systemImage: "square.and.pencil")
        }
    }
}

#Preview {
    let product = ProductModel(productId: "1", thumbnail: "https://i.ibb.co/D9JYsjV/orange-forward.jpg", images: ["https://i.ibb.co/D9JYsjV/orange-forward.jpg", "https://i.ibb.co/GsmsHzN/orange-back.jpg"], title: "Turuncu Elbise", description: "Description", price: 100, sizes: ["34", "36", "38", "40", "42"], category: CategoryType.woman.rawValue, subCategory: WomanSubCategoryType.dress.rawValue, careDetail: "This is a care", exchangeDetail: "This is an exchange")

    return NavigationStack {
        CommentsView(product: product)
            .environmentObject(ProfileViewModel())
            .environmentObject(ProductsViewModel())
    }
}
