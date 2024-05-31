//
//  SearchView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct FavoriesView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @Binding var tabSelection: Int

    @State var favoriteProducts: [ProductModel] = []

    var body: some View {
        ScrollView {
            VStack {
                ForEach(favoriteProducts, id: \.self) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        FavoriRowView(product: product, favoriteProducts: $favoriteProducts)
                    }
                    Divider()
                        .padding(.leading)
                }
            }
            
            if favoriteProducts.isEmpty {
                VStack(spacing: 20) {
                    Text("Favorilerinizde ürün bulunmamaktadır.")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding()
                    
                    Button(action: {
                        tabSelection = 0
                    }) {
                        Text("Ürünleri Keşfet")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 600)
                .padding(36)
            }
            
            
        }
        .navigationTitle("FAVORİLERİM")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .onAppear {
            Task {
                do {
                    favoriteProducts = try await viewModel.getFavoriteProducts()
                } catch {
                    print(error)
                }
            }

//            // For testing
//            favoriteProducts = ProductModel.mockData
        }
    }
}

struct FavoriRowView: View {
    let product: ProductModel
    @Binding var favoriteProducts: [ProductModel]

    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.images.first ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 150)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 150)
            .border(Color.gray, width: 1)

            VStack(alignment: .leading) {
                Text(product.title.uppercased())
                    .font(.headline)
                    .fontWeight(.regular)
                    .lineLimit(2)
                    .foregroundColor(.primary)

                Text("₺\(product.price, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.accentColor)

                Spacer()

                Button(action: handleAddToCart) {
                    Text("Sepete Ekle")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.accentColor)
                        .padding(8)
                        .border(Color.accentColor, width: 1)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .topTrailing) {
                Button(action: handleFavoriteButtonClick) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 1)

            Spacer()
        }

        .padding()
    }
}

extension FavoriRowView {
    func handleFavoriteButtonClick() {
        Task {
            do {
                try await viewModel.toggleFavoriteProduct(product: product)
                favoriteProducts.removeAll { $0.productId == product.productId }
            } catch {
                print(error)
            }
        }
    }

    func isFavorite() -> Bool {
        guard let user = viewModel.user else { return false }

        return user.favoriteProductIDs?.contains(product.productId) ?? false
    }
    
    func handleAddToCart() {
        
    }
}

#Preview {
    NavigationStack {
        FavoriesView(tabSelection: .constant(3))
            .environmentObject(ProfileViewModel())
    }
}
