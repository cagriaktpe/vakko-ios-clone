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
    
    @State private var productCount: Int = 0

    var body: some View {
        ScrollView {
            if category == "Erkek" {
                manSubCategoriesSlider
            } else {
                womanSubCategoriesSlider
            }

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

extension ProductListView {
    var womanSubCategoriesSlider: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(WomanSubCategoryType.allCases, id: \.self) { subCategoryIteration in
                    NavigationLink(destination: ProductListView(category: category, subCategory: subCategoryIteration.rawValue)) {
                        Text(subCategoryIteration.rawValue.uppercased())
                            .font(.subheadline)
                            .foregroundColor(subCategory == subCategoryIteration.rawValue ? Color.white : Color.primary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 5)

                                    .fill(subCategory == subCategoryIteration.rawValue ? Color.accentColor : Color.clear)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(subCategory == subCategoryIteration.rawValue ? Color.clear : Color.black, lineWidth: 1)
                            )
                            .padding(.vertical, 1)
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    var manSubCategoriesSlider: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(ManSubCategoryType.allCases, id: \.self) { subCategoryIteration in
                    NavigationLink(destination: ProductListView(category: category, subCategory: subCategoryIteration.rawValue)) {
                        Text(subCategoryIteration.rawValue.uppercased())
                            .font(.subheadline)
                            .foregroundColor(subCategory == subCategoryIteration.rawValue ? Color.white : Color.primary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(subCategory == subCategoryIteration.rawValue ? Color.accentColor : Color.clear)
                            .cornerRadius(5)
                            .border(subCategory == subCategoryIteration.rawValue ? Color.accentColor : Color.primary, width: 1)
                    }
                }
            }
            .padding(.horizontal)
        }
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

                    Text("₺\(product.price + 100, specifier: "%.2f")")
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
