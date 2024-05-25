//
//  UserManager.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct DBUser: Codable {
    let userId: String
    let name: String?
    let surname: String?
    let phoneNumber: String?
    let birthDate: Date?
    let isAnonymous: Bool?
    let email: String?
    let photoURL: String?
    let dateCreated: Date?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.isAnonymous = auth.isAnonymous
        self.email = auth.email
        self.photoURL = auth.photoURL
        self.dateCreated = Date()
        self.name = nil
        self.surname = nil
        self.phoneNumber = nil
        self.birthDate = nil
    }
    
    init(
        userId: String,
        name: String? = nil,
        surname: String? = nil,
        phoneNumber: String? = nil,
        birthDate: Date? = nil,
        isAnonymous: Bool? = nil,
        email: String? = nil,
        photoURL: String? = nil,
        dateCreated: Date? = nil
        
    ) {
        self.userId = userId
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.birthDate = birthDate
        self.isAnonymous = isAnonymous
        self.email = email
        self.photoURL = photoURL
        self.dateCreated = dateCreated
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name = "name"
        case surname = "surname"
        case phoneNumber = "phone_number"
        case birthDate = "birth_date"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case photoURL = "photo_url"
        case dateCreated = "date_created"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.surname = try container.decodeIfPresent(String.self, forKey: .surname)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        self.birthDate = try container.decodeIfPresent(Date.self, forKey: .birthDate)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoURL = try container.decodeIfPresent(String.self, forKey: .photoURL)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(name, forKey: .name)
        try container.encode(surname, forKey: .surname)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(birthDate, forKey: .birthDate)
        try container.encode(isAnonymous, forKey: .isAnonymous)
        try container.encode(email, forKey: .email)
        try container.encode(photoURL, forKey: .photoURL)
        try container.encode(dateCreated, forKey: .dateCreated)
    }
    
}

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
}
