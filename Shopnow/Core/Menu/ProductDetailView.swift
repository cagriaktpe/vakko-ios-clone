//
//  ProductDetailView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    
    let product: ProductModel
    
    @State private var selectedSize: String = ""
    
    @State private var showDescriptionDetail = false
    @State private var showCareDetail = false
    @State private var showReturnDetail = false
    
    // alert
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                images
                firstSection
                Divider()
                sizeSection
                Divider()
                descriptionRow
                Divider()
                careRow
                Divider()
                returnRow
                Divider()
                commentsRow
                Divider()
            }
            .padding(.bottom, 100)
        }
        .navigationTitle(product.title.uppercased())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
        .overlay(alignment: .bottom) {
            addToCartButton
        }

    }
}

extension ProductDetailView {
    var images: some View {
        TabView {
            ForEach(product.images, id: \.self) { image in
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 600)
        .shadow(radius: 5)
    }
    
    var firstSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title.uppercased())
                    .font(.title2)
                    .foregroundStyle(.primary)
                
                Text("₺\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
                
            }
            
            Spacer()
            
            Button {
                handleFavoriteButtonClick()
            } label: {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .foregroundStyle(isFavorite() ? Color.accentColor : .gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
    
    var sizeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Beden")
                    .font(.body)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text("Beden Tablosu")
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            
            HStack(spacing: 20) {
                ForEach(product.sizes, id: \.self) { size in
                    Button {
                        selectedSize = size
                    } label: {
                        Text(size)
                            .font(.callout)
                            .padding(12)
                            .foregroundStyle(selectedSize == size ? Color.accentColor : .primary)
                            .border(selectedSize == size ? Color.accentColor : .primary, width: 1)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }
    
    var addToCartButton: some View {
        Button {
            handleAddToCart()
        } label: {
            Text("SEPETE EKLE")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }
    
    var descriptionRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                showDescriptionDetail.toggle()
            }, label: {
                HStack {
                    Text("ÜRÜN ÖZELLİKLERİ")
                        .tint(.primary)
                    Spacer()
                    Image(systemName: showDescriptionDetail ? "chevron.down" : "chevron.right")
                        .foregroundStyle(.gray)
                }
            })
            
            
            if showDescriptionDetail {
                Text(product.description)
                    .font(.body)
                    .foregroundStyle(Color.primary)
                
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    var careRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                showCareDetail.toggle()
            }, label: {
                HStack {
                    Text("BAKIM")
                        .tint(.primary)
                    Spacer()
                    Image(systemName: showCareDetail ? "chevron.down" : "chevron.right")
                        .foregroundStyle(.gray)
                }
            })
            
            
            if showCareDetail {
                Text(product.careDetail)
                    .font(.body)
                    .foregroundStyle(Color.primary)
                
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    var returnRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                showReturnDetail.toggle()
            }, label: {
                HStack {
                    Text("İADE & DEĞİŞİM")
                        .tint(.primary)
                    Spacer()
                    Image(systemName: showReturnDetail ? "chevron.down" : "chevron.right")
                        .foregroundStyle(.gray)
                }
            })
            
            
            if showReturnDetail {
                Text(product.exchangeDetail)
                    .font(.body)
                    .foregroundStyle(Color.primary)
                
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    var commentsRow: some View {
        
        NavigationLink(destination: CommentsView(product: product)) {
            HStack {
                Text("YORUMLAR")
                    .tint(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        
        
        
    }
}

extension ProductDetailView {
    func handleFavoriteButtonClick() {
        Task {
            do {
                try await viewModel.toggleFavoriteProduct(product: product)
            } catch {
                makeAlert(title: "Hata", message: error.localizedDescription)
            }
        }
    }
    
    func handleAddToCart() {
        if selectedSize.isEmpty {
            makeAlert(title: "Hata", message: "Lütfen bir beden seçiniz.")
            return
        }
        
        do {
            try cartViewModel.addProduct(product: product, size: selectedSize, quantity: 1)
        } catch {
            makeAlert(title: "Hata", message: error.localizedDescription)
            return
        }
        
        makeAlert(title: "Başarılı", message: "Ürün sepete eklendi.")
    }
    
    func isFavorite() -> Bool {
        guard let user = viewModel.user else { return false }
        
        return user.favoriteProductIDs?.contains(product.productId) ?? false
    }
    
    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}

#Preview {
    
    let product = ProductModel(productId: "1", thumbnail: "https://i.ibb.co/D9JYsjV/orange-forward.jpg", images: ["https://i.ibb.co/D9JYsjV/orange-forward.jpg", "https://i.ibb.co/GsmsHzN/orange-back.jpg"], title: "Turuncu Elbise", description: "Description", price: 100, sizes: ["34", "36", "38", "40", "42"], category: CategoryType.woman.rawValue, subCategory: WomanSubCategoryType.dress.rawValue, careDetail: "This is a care", exchangeDetail: "This is an exchange")
    
    return NavigationStack {
         ProductDetailView(product: product)
            .environmentObject(ProfileViewModel())
    }
}
