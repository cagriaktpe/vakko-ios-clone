//
//  AuthenticationViewModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//


import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    // Shared
    @Published var email = ""
    @Published var password = ""
    
    // Sign Up
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var phoneNumber: String = ""
    @Published var birthDate: Date? = nil
    @Published var selectedDate: Date = Date() {
        didSet {
            birthDate = selectedDate
        }
    }
    
    // Sign Up with Anonymously
    func signInWithAnonymous() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInAnonymously()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    // Sign Up with Email
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "AuthenticationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "No email or password found."])
        }

        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(userId: authDataResult.uid, name: name, surname: surname, phoneNumber: phoneNumber, birthDate: birthDate, isAnonymous: false, email: email, photoURL: nil, dateCreated: Date())
        
        
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "AuthenticationViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "No email or password found."])
        }

        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
