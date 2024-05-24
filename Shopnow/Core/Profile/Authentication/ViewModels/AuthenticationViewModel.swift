//
//  AuthenticationViewModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//


import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    // Sign Up with Anonymously
    func signInWithAnonymous() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInAnonymously()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    // Sign Up with Email
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
