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
    @Binding var tabSelection: Int

    var body: some View {
        List {
            header
                .listRowInsets(EdgeInsets())

            NavigationLink(destination: Text("SİPARİŞLERİM")) {
                Text("SİPARİŞLERİM")
            }

            NavigationLink(destination: Text("İPTAL ve İADE İŞLEMLERİ")) {
                Text("İPTAL ve İADE İŞLEMLERİ")
            }

            NavigationLink(destination: Text("FAVORİLERİM")) {
                Text("FAVORİLERİM")
            }

            NavigationLink(destination: Text("HESABIM")) {
                Text("HESABIM")
            }

            NavigationLink(destination: Text("SHOPNOW CARD")) {
                Text("SHOPNOW CARD")
            }

            NavigationLink(destination: Text("ADRESLERİM")) {
                Text("ADRESLERİM")
            }

            NavigationLink(destination: Text("EPOSTA DEĞİŞTİRME")) {
                Text("EPOSTA DEĞİŞTİRME")
            }

            NavigationLink(destination: Text("ŞİFRE DEĞİŞTİRME")) {
                Text("ŞİFRE DEĞİŞTİRME")
            }

            NavigationLink(destination: Text("KUPONLARIM")) {
                Text("KUPONLARIM")
            }

            NavigationLink(destination: Text("İLETİŞİM İZİNLERİ")) {
                Text("İLETİŞİM İZİNLERİ")
            }

            NavigationLink(destination: Text("ÇIKIŞ YAP")) {
                Text("ÇIKIŞ YAP")
            }
        }
        .listStyle(.plain)
        .navigationTitle("PROFİLİM")
        .navigationBarTitleDisplayMode(.inline)
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
                SignInView(showSignedInView: $showSignInView, tabSelection: $tabSelection)
            }
        })
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

extension ProfileView {
    var header: some View {
        VStack(spacing: 5) {
            if let name = viewModel.user?.name,
               let surname = viewModel.user?.surname {
                Text("\(name) \(surname)")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.bold)
            }

            if let email = viewModel.user?.email {
                Text(email)
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(maxHeight: .infinity, alignment: .center)
        .padding(.vertical, 5)
        .background(Color.accentColor)
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false), tabSelection: .constant(5))
    }
}
