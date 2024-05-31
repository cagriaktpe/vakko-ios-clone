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
    @Published var comments: [CommentModel] = []
    
    init() {
        Task {
            do {
                try await fetchProducts()
                try await getAllComments()
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
    
    func getAllComments() async throws {
        do {
            comments = try await CommentManager.shared.getAllComments()
        } catch {
            print(error)
        }
    }
    
    func addComment(comment: CommentModel) throws {
        try CommentManager.shared.createComment(comment: comment)
        comments.append(comment)
    }
    
    func removeComment(commentId: String) async throws {
        try await CommentManager.shared.removeComment(commentId: commentId)
        comments.removeAll { $0.commentId == commentId }
    }
}
