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

    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            VStack {
                ForEach(favoriteProducts, id: \.self) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        FavoriRowView(product: product, favoriteProducts: $favoriteProducts, showAlert: $showAlert, alertTitle: $alertTitle, alertMessage: $alertMessage)
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
        .onAppear {
            Task {
                do {
                    favoriteProducts = try await viewModel.getFavoriteProducts()
                } catch {
                    makeAlert(title: "Hata", message: error.localizedDescription)
                }
            }

            // For testing
//            favoriteProducts = ProductModel.mockData
        }
    }
}

extension FavoriesView {
    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    NavigationStack {
        FavoriesView(tabSelection: .constant(3))
            .environmentObject(ProfileViewModel())
    }
}
