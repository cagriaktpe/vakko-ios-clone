//
//  ProductListView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var vm: ProductsViewModel

    let category: String
    let subCategory: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(vm.products, id: \.self) { product in
                    if category == product.category && subCategory == product.subCategory {
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductCard(product: product)
                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 8)
        }
        .navigationTitle(subCategory.uppercased())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

struct ProductCard: View {
    let product: ProductModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 280)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 180, height: 280)

            VStack(alignment: .center) {
                Text(product.title.uppercased())
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundStyle(Color.primary)

                HStack {
                    Text("₺\(product.price, specifier: "%.2f")")
                        .font(.footnote)
                        .foregroundStyle(Color.accentColor)
                    
                    Text ("₺\(product.price + 100, specifier: "%.2f")")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .strikethrough()
                }
                
            }
        }
        .background(.ultraThinMaterial)
        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        ProductListView(category: CategoryType.woman.rawValue, subCategory: WomanSubCategoryType.dress.rawValue)
            .environmentObject(ProductsViewModel())
    }
    
}
