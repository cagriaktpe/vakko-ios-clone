//
//  ProductManager.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class ProductsManager {
    
    static let shared = ProductsManager()
    
    private init() {}
    
    private let productsCollection = Firestore.firestore().collection("products")
    
    private func productDocument(productId: String) -> DocumentReference {
        return productsCollection.document(productId)
    }
    
    func uploadProduct(product: ProductModel) async throws {
        try productDocument(productId: String(product.id)).setData(from: product, merge: false)
    }
    
    func getProduct(productId: String) async throws -> ProductModel {
        try await productDocument(productId: productId).getDocument(as: ProductModel.self)
    }
    
    func getAllProducts() async throws -> [ProductModel] {
        try await productsCollection.getDocuments(as: ProductModel.self)
    }
}

extension Query {
    func getDocuments<T>(as: T.Type) async throws -> [T] where T : Decodable {
        let querySnapshot = try await self.getDocuments()
        
        return try querySnapshot.documents.compactMap { try $0.data(as: T.self) }
    }
}
