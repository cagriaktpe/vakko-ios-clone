//
//  BasketView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct BasketView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    
    @Binding var tabSelection: Int
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(cartViewModel.selectedProducts, id: \.self) { selectedProduct in
                    BasketRowView(selectedProduct: selectedProduct, quantity: Binding(get: {
                        cartViewModel.selectedProducts.first(where: { $0.product.productId == selectedProduct.product.productId && $0.size == selectedProduct.size })?.quantity ?? 1
                    }, set: { newValue in
                        cartViewModel.updateQuantity(product: selectedProduct.product, size: selectedProduct.size, quantity: newValue)
                    }))
                        
                    Divider()
                }
                
                if !cartViewModel.selectedProducts.isEmpty { priceRow }
                
                if cartViewModel.selectedProducts.isEmpty { emptyView }
            }
            .padding(.bottom, 100)
            
        }
        .navigationTitle("SEPETİM")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
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
    var emptyView: some View {
        VStack(spacing: 20) {
            Text("Sepetinizde ürün bulunmamaktadır.")
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
    
    var priceRow: some View {
        HStack {
            Text("Toplam Tutar")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text("₺\(cartViewModel.total, specifier: "%.2f")")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
        }
        .padding()
    }
    
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
        cartViewModel.clearCart()
        makeAlert(title: "Başarılı", message: "Siparişiniz alınmıştır.")
    }
    
    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}

#Preview {
    NavigationStack {
        BasketView(tabSelection: .constant(3))
            .environmentObject(CartViewModel())
            .environmentObject(ProfileViewModel())
    }
}
