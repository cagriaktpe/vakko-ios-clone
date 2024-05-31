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

    func addProduct(product: ProductModel, size: String, quantity: Int) {
        // if already contains the product, update the quantity otherwise just add
        if let index = selectedProducts.firstIndex(where: { $0.product.productId == product.productId && $0.size == size }) {
            print("Quantity Before: \(quantity)")
            selectedProducts[index].quantity += quantity
            print("Quantity After: \(selectedProducts[index].quantity)")
        } else {
            selectedProducts.append(SelectedProductModel(product: product, size: size, quantity: quantity))
            print(quantity)
        }
    }
    
    func removeProduct(product: ProductModel, size: String) {
        selectedProducts.removeAll { $0.product.productId == product.productId && $0.size == size }
    }
    
    func updateQuantity(product: ProductModel, size: String, quantity: Int) {
        guard let index = selectedProducts.firstIndex(where: { $0.product.productId == product.productId && $0.size == size }) else { return }
        selectedProducts[index].quantity = quantity
    }
    
    func clearCart() {
        selectedProducts.removeAll()
    }
}
