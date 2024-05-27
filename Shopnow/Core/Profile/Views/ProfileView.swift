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

            ZStack {
                NavigationLink(destination: Text("SİPARİŞLERİM")) {
                    EmptyView()
                }

                HStack {
                    Text("SİPARİŞLERİM")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("İPTAL ve İADE İŞLEMLERİ")) {
                    EmptyView()
                }

                HStack {
                    Text("İPTAL ve İADE İŞLEMLERİ")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("FAVORİLERİM")) {
                    EmptyView()
                }

                HStack {
                    Text("FAVORİLERİM")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("HESABIM")) {
                    EmptyView()
                }

                HStack {
                    Text("HESABIM")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("SHOPNOW CARD")) {
                    EmptyView()
                }

                HStack {
                    Text("SHOPNOW CARD")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("ADRESLERİM")) {
                    EmptyView()
                }

                HStack {
                    Text("ADRESLERİM")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("EPOSTA DEĞİŞTİRME")) {
                    EmptyView()
                }

                HStack {
                    Text("EPOSTA DEĞİŞTİRME")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("ŞİFRE DEĞİŞTİRME")) {
                    EmptyView()
                }

                HStack {
                    Text("ŞİFRE DEĞİŞTİRME")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("KUPONLARIM")) {
                    EmptyView()
                }

                HStack {
                    Text("KUPONLARIM")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            ZStack {
                NavigationLink(destination: Text("İLETİŞİM İZİNLERİ")) {
                    EmptyView()
                }

                HStack {
                    Text("İLETİŞİM İZİNLERİ")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            }

            HStack {
                Button(action: handleSignOut) {
                    Text("ÇIKIŞ YAP")
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
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
                Text("\(name) \(surname)".uppercased())
                    .foregroundStyle(.white)
                    .font(.headline)
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

extension ProfileView {
    func handleSignOut() {
        do {
            try viewModel.signOut()
            showSignInView = true
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false), tabSelection: .constant(5))
    }
}
