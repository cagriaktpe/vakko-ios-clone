//
//  ProfileView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ProfileViewModel

    @Binding var showSignInView: Bool
    @Binding var tabSelection: Int
    
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage = ""

    var body: some View {
        List {
            header
                .listRowInsets(EdgeInsets())
            orders
            favorites
            account
            addresses
            logoutButton
        }
        .listStyle(.plain)
        .navigationTitle("PROFİLİM")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                SignInView(showSignedInView: $showSignInView, tabSelection: $tabSelection)
            }
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
        .onChange(of: showSignInView) { _ in
            Task {
                try? await viewModel.loadCurrentUser()
            }
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

    var orders: some View {
        ZStack {
            NavigationLink(destination: Text("SİPARİŞLERİM")) {
                EmptyView()
            }
            .opacity(0)

            HStack {
                Text("SİPARİŞLERİM")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
    }

    var favorites: some View {
        ZStack {
            NavigationLink(destination: FavoriesView(tabSelection: $tabSelection)) {
                EmptyView()
            }
            .opacity(0)

            HStack {
                Text("FAVORİLERİM")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
    }

    var account: some View {
        ZStack {
            NavigationLink(destination: MyAccountView(showSignedInView: $showSignInView, tabSelection: $tabSelection)) {
                EmptyView()
            }
            .opacity(0)

            HStack {
                Text("HESABIM")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
    }

    var addresses: some View {
        ZStack {
            NavigationLink(destination: MyAddressesView()) {
                EmptyView()
            }
            .opacity(0)

            HStack {
                Text("ADRESLERİM")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
        }
    }

    var logoutButton: some View {
        HStack {
            Button(action: handleSignOut) {
                Text("ÇIKIŞ YAP")
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
    }
}

extension ProfileView {
    func handleSignOut() {
        do {
            try viewModel.signOut()
            showSignInView = true
        } catch {
            makeAlert(title: "Hata", message: "Çıkış yapılırken bir hata oluştu.")
        }
    }
    
    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false), tabSelection: .constant(5))
            .environmentObject(ProfileViewModel())
    }
}

// Other related fields to add
//            ZStack {
//                NavigationLink(destination: Text("İPTAL ve İADE İŞLEMLERİ")) {
//                    EmptyView()
//                }
//                .opacity(0)
//
//                HStack {
//                    Text("İPTAL ve İADE İŞLEMLERİ")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.gray)
//                }
//            }
//            .disabled(true)
//            .foregroundStyle(Color.secondary)

//            ZStack {
//                NavigationLink(destination: Text("SHOPNOW CARD")) {
//                    EmptyView()
//                }
//                .opacity(0)
//
//                HStack {
//                    Text("SHOPNOW CARD")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.gray)
//                }
//            }
//            .disabled(true)
//            .foregroundStyle(Color.secondary)

//            ZStack {
//                NavigationLink(destination: UpdateEmailView(vm: viewModel, showSignedInView: $showSignInView, tabSelection: $tabSelection)) {
//                    EmptyView()
//                }
//                .opacity(0)
//
//                HStack {
//                    Text("EPOSTA DEĞİŞTİRME")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.gray)
//                }
//            }
//            .disabled(true)
//            .foregroundStyle(Color.secondary)

//            ZStack {
//                NavigationLink(destination: Text("ŞİFRE DEĞİŞTİRME")) {
//                    EmptyView()
//                }
//                .opacity(0)
//
//                HStack {
//                    Text("ŞİFRE DEĞİŞTİRME")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.gray)
//                }
//            }
//            .disabled(true)
//            .foregroundStyle(Color.secondary)

//            ZStack {
//                NavigationLink(destination: Text("KUPONLARIM")) {
//                    EmptyView()
//                }
//                .opacity(0)
//
//                HStack {
//                    Text("KUPONLARIM")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.gray)
//                }
//            }
//            .disabled(true)
//            .foregroundStyle(Color.secondary)

//            ZStack {
//                NavigationLink(destination: Text("İLETİŞİM İZİNLERİ")) {
//                    EmptyView()
//                }
//                .opacity(0)
//
//                HStack {
//                    Text("İLETİŞİM İZİNLERİ")
//                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.gray)
//                }
//            }
//            .disabled(true)
//            .foregroundStyle(Color.secondary)
