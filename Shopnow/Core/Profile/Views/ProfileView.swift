//
//  ProfileView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Section(header: Text("User Information")) {
                    HStack {
                        Text("UserId:")
                        Spacer()
                        Text(user.userId)
                    }

                    HStack {
                        Text("Is Anonymous:")
                        Spacer()
                        Text(user.isAnonymous?.description.capitalized ?? "N/A")
                    }

                    HStack {
                        Text("Email:")
                        Spacer()
                        Text(user.email ?? "N/A")
                    }
                }
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView(showSignedInView: $showSignInView)) {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                SignInView(showSignedInView: $showSignInView)
            }
        })
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
