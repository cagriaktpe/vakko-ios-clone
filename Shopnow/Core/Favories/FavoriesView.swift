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
    
    // alert
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // size picker
    @State private var showSizePicker = false

    var body: some View {
        ScrollView {
            VStack {
                ForEach(favoriteProducts, id: \.self) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        FavoriRowView(product: product, favoriteProducts: $favoriteProducts, showSizePicker: $showSizePicker, showAlert: $showAlert, alertTitle: $alertTitle, alertMessage: $alertMessage)
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
                    print(error)
                }
            }

            // For testing
//            favoriteProducts = ProductModel.mockData
        }
    }
}

struct FavoriRowView: View {
    let product: ProductModel
    @Binding var favoriteProducts: [ProductModel]

    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    // size
    @State private var selectedSize = ""
    @Binding var showSizePicker: Bool
    
    // alert
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
        .sheet(isPresented: $showSizePicker) {
            SizePicker(selectedSize: $selectedSize, showSizePicker: $showSizePicker, showAlert: $showAlert, alertTitle: $alertTitle, alertMessage: $alertMessage, product: product)
                .presentationDetents([.height(250)])
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
        if selectedSize.isEmpty {
            showSizePicker.toggle()
            return
        }
        
        cartViewModel.addProduct(product: product, size: selectedSize, quantity: 1)
        
        alertTitle = "Başarılı"
        alertMessage = "Ürün sepete eklendi."
        showAlert = true
    }
}

struct SizePicker: View {
    @Binding var selectedSize: String
    @Binding var showSizePicker: Bool
    
    @EnvironmentObject var cartViewModel: CartViewModel
    
    // alert
    @Binding var showAlert: Bool
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    
    let product: ProductModel

    var body: some View {
        
        Picker("Beden Seçimi", selection: $selectedSize) {
            ForEach(product.sizes, id: \.self) { size in
                Text(size)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding()
            }
        }
        .pickerStyle(.wheel)
        .overlay(alignment: .topTrailing) {
            Button(action: {
                showSizePicker = false
                handleAddToCart()
            }) {
                Text("Tamam")
                    .font(.headline)
                    .foregroundColor(Color.accentColor)
            }
            .padding(.trailing)
        }
    }
    
    func handleAddToCart() {
        if selectedSize.isEmpty {
            showSizePicker.toggle()
            return
        }
        
        cartViewModel.addProduct(product: product, size: selectedSize, quantity: 1)
        
        alertTitle = "Başarılı"
        alertMessage = "Ürün sepete eklendi."
        showAlert = true
    }
}

#Preview {
    NavigationStack {
        FavoriesView(tabSelection: .constant(3))
            .environmentObject(ProfileViewModel())
    }
}
