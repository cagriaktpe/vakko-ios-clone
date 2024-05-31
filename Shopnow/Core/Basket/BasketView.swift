//
//  BasketView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cartViewModel.selectedProducts, id: \.self) { selectedProduct in
                    BasketRowView(selectedProduct: selectedProduct)
                    Divider()
                }
            }
            
            
        }
        .navigationTitle("SEPETİM")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .overlay(alignment: .bottom) {
            if !cartViewModel.selectedProducts.isEmpty {
                approveButton
            }
        }
//        .onAppear {
//            cartViewModel.addProduct(product: ProductModel.mockData[0], size: "M", quantity: 1)
//            cartViewModel.addProduct(product: ProductModel.mockData[1], size: "M", quantity: 3)
//        }
        
    }
}

extension BasketView {
    var approveButton: some View {
        Button(action: handleApproveButtonClick) {
            Text("SEPETİ ONAYLA")
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
}
    
    
extension BasketView {
    func handleApproveButtonClick() {
        
    }
}

struct BasketRowView: View {
    let selectedProduct: SelectedProductModel
    @State private var quantity: Int = 0

    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var cartViewModel: CartViewModel

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: selectedProduct.product.images.first ?? "")) { image in
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
                Text(selectedProduct.product.title.uppercased())
                    .font(.headline)
                    .fontWeight(.regular)
                    .lineLimit(2)
                    .foregroundColor(.primary)

                Text("₺\(selectedProduct.product.price, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.accentColor)
                
                Text("Beden: \(selectedProduct.size)")
                    .padding(.vertical, 5)
                
                Picker("Adet", selection: $quantity) {
                    ForEach(1..<10) { i in
                        Text("\(i) adet")
                    }
                }
                .pickerStyle(.menu)
                .border(Color.gray, width: 1)
                .padding(.top, 10)
                .onChange(of: quantity) { quantity in
                    cartViewModel.updateQuantity(product: selectedProduct.product, size: selectedProduct.size, quantity: quantity)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .topTrailing) {
                Button(action: handleDiscardButtonClick) {
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

extension BasketRowView {
    func handleDiscardButtonClick() {
        cartViewModel.removeProduct(product: selectedProduct.product, size: selectedProduct.size)
    }

}

#Preview {
    NavigationStack {
        BasketView()
            .environmentObject(CartViewModel())
            .environmentObject(ProfileViewModel())
    }
    
}
