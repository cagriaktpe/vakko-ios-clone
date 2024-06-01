//
//  SettingsViewModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//

// NOTE: THIS VIEWMODEL IS WRITTEN FOR TESTING PURPOSES. IT IS NOT USED IN THE PROJECT
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResultModel? = nil

    func loadAuthProviders() {
        if let authProviders = try? AuthenticationManager.shared.getProviders() {
            self.authProviders = authProviders
        }
    }

    func loadAuthUser() {
        if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
            self.authUser = authUser
        }
    }

    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.deleteAccount()
    }

    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()

        guard let email = authUser.email else {
            throw NSError(domain: "SettingsViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "No email found."])
        }

        try await AuthenticationManager.shared.resetPassword(email: email)
    }

    func updatePassword(newPassword: String) async throws {
        try await AuthenticationManager.shared.updatePassword(newPassword: newPassword)
    }

//    func updateEmail() async throws {
//        try await AuthenticationManager.shared.updateEmail(newEmail: <#String#>, password: <#String#>)
//    }

    func linkEmailAccount() async throws {
        let email = "testtest@hello.com"
        let password = "testtest"
        authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    }
}
