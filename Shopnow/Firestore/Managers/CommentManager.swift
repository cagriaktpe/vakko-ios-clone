//
//  CommentManager.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class CommentManager {
    
    static let shared = CommentManager()
    
    private init() {}
    
    private let commentsCollection = Firestore.firestore().collection("comments")
    
    private func commentDocument(commentId: String) -> DocumentReference {
        return commentsCollection.document(commentId)
    }
    
    func getComment(commentId: String) async throws -> CommentModel {
        try await commentDocument(commentId: commentId).getDocument(as: CommentModel.self)
    }
    
    func getAllComments() async throws -> [CommentModel] {
        return try await commentsCollection.getDocuments(as: CommentModel.self)
    }
    
    func createComment(comment: CommentModel) throws {
        try commentsCollection.addDocument(from: comment)
    }
    
    func removeComment(commentId: String) async throws {
        let snapshot = try await commentsCollection.whereField("comment_id", isEqualTo: commentId).getDocuments()
        for document in snapshot.documents {
            try await commentsCollection.document(document.documentID).delete()
        }
        
    }
    
    func printJSON() async throws {
        Task {
            do {
                let snapshot = try await commentsCollection.getDocuments()
                for document in snapshot.documents {
                    print(document.data())
                }
                
            } catch {
                print(error)
            }
        }
    }
}

