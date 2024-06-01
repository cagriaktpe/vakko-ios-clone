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
    
    func setPreferredAddress(userId: String, addressId: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.preferredAddressId.rawValue: addressId
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
}

// address management
extension UserManager {
    func addAddress(userId: String, address: AddressModel) async throws {
        let data: [String: Any] = [
            "addresses": FieldValue.arrayUnion([try encoder.encode(address)])
        ]
        
        try await userDocument(userId: userId).updateData(data)
                
        try await setPreferredAddress(userId: userId, addressId: address.id)
    }
    
    func deleteAddress(userId: String, address: AddressModel) async throws {
        let data: [String: Any] = [
            "addresses": FieldValue.arrayRemove([try encoder.encode(address)])
        ]
        
        try await userDocument(userId: userId).updateData(data)
        
        let user = try await getUser(userId: userId)
        
        if user.preferredAddressId == address.id {
            try await setPreferredAddress(userId: userId, addressId: "")
        }
    }
    
    func updateAddress(userId: String, addressToUpdate: AddressModel, newAddress: AddressModel) async throws {
        let dataToRemove: [String: Any] = [
            "addresses": FieldValue.arrayRemove([try encoder.encode(addressToUpdate)])
        ]
        
        try await userDocument(userId: userId).updateData(dataToRemove)
        
        let dataToAdd: [String: Any] = [
            "addresses": FieldValue.arrayUnion([try encoder.encode(newAddress)])
        ]
        
        try await userDocument(userId: userId).updateData(dataToAdd)
    }
}

// favorite management
extension UserManager {
    func toggleFavoriteProduct(userId: String, productId: String) async throws {
        let user = try await getUser(userId: userId)
        
        print("I WORKED from UserManager")
       
        if user.favoriteProductIDs?.contains(productId) == true {
            try await removeFavoriteProduct(userId: userId, productId: productId)
            print("I WORKED from UserManager: removeFavoriteProduct")
        } else {
            try await addFavoriteProduct(userId: userId, productId: productId)
            print("I WORKED from UserManager: addFavoriteProduct")
        }
    }
    
    private func addFavoriteProduct(userId: String, productId: String) async throws {
        let data: [String: Any] = [
            "favorite_product_ids": FieldValue.arrayUnion([productId])
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    private func removeFavoriteProduct(userId: String, productId: String) async throws {
        let data: [String: Any] = [
            "favorite_product_ids": FieldValue.arrayRemove([productId])
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    func getFavoriteProducts(userId: String) async throws -> [ProductModel] {
        let user = try await getUser(userId: userId)
        
        let favoriteProductIDs = user.favoriteProductIDs ?? []
        
        var favoriteProducts: [ProductModel] = []
        
        for productID in favoriteProductIDs {
            let product = try await ProductsManager.shared.getProduct(productId: productID)
            favoriteProducts.append(product)
        }
        
        return favoriteProducts
    }
    
    func isProductFavorite(userId: String, productId: String) async throws -> Bool {
        let user = try await getUser(userId: userId)
        
        return user.favoriteProductIDs?.contains(productId) ?? false
    }
}
