//
//  ProductsViewModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import Foundation

@MainActor
final class ProductsViewModel: ObservableObject {
    
    @Published var products: [ProductModel] = []
    
    init() {
        Task {
            do {
                try await fetchProducts()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchProducts() async throws {
        do {
            products = try await ProductsManager.shared.getAllProducts()
        } catch {
            print(error)
        }
    }
    
}
