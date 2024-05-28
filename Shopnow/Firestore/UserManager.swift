//
//  UserManager.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class UserManager {
    
    static let shared = UserManager()
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private init() { }
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)        
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func deleteUser(userId: String) async throws {
        try await userDocument(userId: userId).delete()
    }
    
    func updateUser(userId: String, newName name: String, newSurname surname: String, newPhoneNumber phoneNumber: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.name.rawValue: name,
            DBUser.CodingKeys.surname.rawValue: surname,
            DBUser.CodingKeys.phoneNumber.rawValue: phoneNumber
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    func updateUserEmail(userId: String, newEmail email: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.email.rawValue: email
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    func setPreferredAddress(userId: String, address: AddressModel) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.preferredAddress.rawValue: try encoder.encode(address)
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
}

extension UserManager {
    func addAddress(userId: String, address: AddressModel) async throws {
        let data: [String: Any] = [
            "addresses": FieldValue.arrayUnion([try encoder.encode(address)])
        ]
        
        try await userDocument(userId: userId).updateData(data)
        
        let user = try await getUser(userId: userId)
        
        if user.preferredAddress == nil {
            try await setPreferredAddress(userId: userId, address: address)
        }
    }
}
