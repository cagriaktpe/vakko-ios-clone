//
//  FavoriRowView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 1.06.2024.
//

import SwiftUI

struct FavoriRowView: View {
    let product: ProductModel
    @Binding var favoriteProducts: [ProductModel]

    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    @Binding var showAlert: Bool
    @Binding var alertTitle: String
    @Binding var alertMessage: String

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

                NavigationLink(destination: ProductDetailView(product: product)) {
                    Text("Ürünü İncele")
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
                makeAlert(title: "Hata", message: error.localizedDescription)
            }
        }
    }

    func isFavorite() -> Bool {
        guard let user = viewModel.user else { return false }

        return user.favoriteProductIDs?.contains(product.productId) ?? false
    }
    
    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
}
