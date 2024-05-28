//
//  ProfileViewModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
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
        user = nil
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.deleteAccount()
        user = nil
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

    func updateEmail(newEmail email: String, password: String) async throws {
        try await AuthenticationManager.shared.updateEmail(newEmail: email, password: password)
    }

    func linkEmailAccount() async throws {
        let email = "testtest@hello.com"
        let password = "testtest"
        authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    }

    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }    
    
    func updateUser(newName name: String, newSurname surname: String, newPhoneNumber phoneNumber: String) {
        guard let user = user else { return }
        
        Task {
            try? await UserManager.shared.updateUser(userId: user.userId, newName: name, newSurname: surname, newPhoneNumber: phoneNumber)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func verifyEmail() async throws {
        try await AuthenticationManager.shared.verifyEmail()
    }
    
    func addAddress(address: AddressModel) async throws {
        guard let user = user else { return }
        
        try await UserManager.shared.addAddress(userId: user.userId, address: address)
        self.user = try await UserManager.shared.getUser(userId: user.userId)
    }
    
    func setPreferredAddress(addressId: String) async throws {
        guard let user = user else { return }
        
        try await UserManager.shared.setPreferredAddress(userId: user.userId, addressId: addressId)
        self.user = try await UserManager.shared.getUser(userId: user.userId)
    }
}
