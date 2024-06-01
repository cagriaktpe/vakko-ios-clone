//
//  CartViewModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import Foundation

@MainActor
final class CartViewModel: ObservableObject {
    @Published private(set) var selectedProducts: [SelectedProductModel] = []
    @Published var total: Double = 0

    func addProduct(product: ProductModel, size: String, quantity: Int) throws {
        // if already contains the product, update the quantity otherwise just add
        if let index = selectedProducts.firstIndex(where: { $0.product.productId == product.productId && $0.size == size }) {
            
            if selectedProducts[index].quantity >= 10 {
                throw NSError(domain: "com.shopnow", code: 1, userInfo: [NSLocalizedDescriptionKey: "Maximum 10 adet seçebilirsiniz."])
            }
            
            selectedProducts[index].quantity += quantity
            total += product.price
        } else {
            selectedProducts.append(SelectedProductModel(product: product, size: size, quantity: quantity))
            total += product.price * Double(quantity)
        }
    }
    
    func removeProduct(product: ProductModel, size: String) {
        total -= product.price
        selectedProducts.removeAll { $0.product.productId == product.productId && $0.size == size }
    }
    
    func updateQuantity(product: ProductModel, size: String, quantity: Int)  {
        guard let index = selectedProducts.firstIndex(where: { $0.product.productId == product.productId && $0.size == size }) else { return }
        selectedProducts[index].quantity = quantity
        total = selectedProducts.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
    }
    
    func clearCart() {
        selectedProducts.removeAll()
        total = 0
    }
}
