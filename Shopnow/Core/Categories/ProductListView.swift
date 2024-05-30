//
//  ProductListView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var vm: ProductsViewModel

    let category: String
    let subCategory: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(vm.products) { product in
                    
                    if category == CategoryType.man.rawValue && subCategory == ManSubCategoryType(rawValue: product.subCategory)?.rawValue {
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductCard(product: product)
                        }
                        
                    } else if category == CategoryType.woman.rawValue && subCategory == WomanSubCategoryType(rawValue: product.subCategory)?.rawValue {
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductCard(product: product)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            print(vm.products)
        }
        .navigationTitle(subCategory)
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
                    .frame(width: 170, height: 280)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 170, height: 280)

            VStack(alignment: .center) {
                Text(product.title.uppercased())
                    .font(.headline)
                    .foregroundStyle(Color.primary)

                Text("₺\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
            }
        }
        .background(.ultraThinMaterial)
        .shadow(radius: 5)
    }
}

#Preview {
    NavigationStack {
        ProductListView(vm: ProductsViewModel(), category: CategoryType.woman.rawValue, subCategory: WomanSubCategoryType.dress.rawValue)
    }
    
}
