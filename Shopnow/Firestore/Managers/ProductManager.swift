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

    func getProduct(productId: String) async throws -> ProductModel {
        try await productDocument(productId: productId).getDocument(as: ProductModel.self)
    }

    func getAllProducts() async throws -> [ProductModel] {
        return try await productsCollection.getDocuments(as: ProductModel.self)
    }

    // this is a test function
    func printJSON() async throws {
        Task {
            do {
                let snapshot = try await productsCollection.getDocuments()
                for document in snapshot.documents {
                    print(document.data())
                }

            } catch {
                print(error)
            }
        }
    }
}

extension Query {
    func getDocuments<T>(as: T.Type) async throws -> [T] where T: Decodable {
        return try await withCheckedThrowingContinuation { continuation in
            self.getDocuments { snapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    do {
                        let documents = try snapshot?.documents.compactMap { try $0.data(as: T.self) } ?? []
                        continuation.resume(returning: documents)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
