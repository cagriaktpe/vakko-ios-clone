//
//  SettingsView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//


// NOTE: THIS VIEW IS WRITTEN FOR TESTING PURPOSES. IT IS NOT USED IN THE PROJECT.
import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    @Binding var showSignedInView: Bool

    var body: some View {
        List {
            Button {
                Task {
                    do {
                        try vm.signOut()
                        showSignedInView = true
                    } catch {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Log out")
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await vm.deleteAccount()
                        showSignedInView = true
                    } catch {
                        print("Error deleting account: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Delete Account")
            }

            if vm.authProviders.contains(.email) {
                emailSection
            }

            if vm.authUser?.isAnonymous == true {
                anonymousSection
            }
        }
        .onAppear {
            vm.loadAuthProviders()
            vm.loadAuthUser()
        }
        .navigationTitle("Settings")
    }
}

extension SettingsView {
    private var emailSection: some View {
        Section("Email functions") {
            Button {
                Task {
                    do {
                        try await vm.updatePassword(newPassword: "fake-password")
                        print("Password reset email sent.")
                    } catch {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Update password")
            }

//            Button {
//                Task {
//                    do {
//                        try await vm.updateEmail()
//                        print("email reset email sent.")
//                    } catch {
//                        print("Error signing out: \(error.localizedDescription)")
//                    }
//                }
//            } label: {
//                Text("Update email")
//            }

            Button {
                Task {
                    do {
                        try await vm.resetPassword()
                        print("Password reset email sent.")
                    } catch {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Reset password")
            }
        }
    }

    private var anonymousSection: some View {
        Section("Create Account") {
            Button {
                Task {
                    do {
                        try await vm.linkEmailAccount()
                        print("Email account linked.")
                    } catch {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }

            } label: {
                Text("Link Email Account")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignedInView: .constant(false))
    }
}
