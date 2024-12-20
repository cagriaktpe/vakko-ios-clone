//
//  SignInView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 16.05.2024.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var vm = AuthenticationViewModel()
    
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage = ""
    
    @Binding var showSignedInView: Bool
    @Binding var tabSelection: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                signInSection
                
                registerSection
            }
            .padding(.top)
        }
        .navigationTitle("GİRİŞ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    tabSelection = 0
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
}

extension SignInView {
    var signInSection: some View {
        Section {
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-posta")
                        .font(.subheadline)
                        .fontWeight(.light)

                    TextField("", text: $vm.email)
                        .padding(12)
                        .border(Color.gray, width: 1)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                }
                

                VStack(alignment: .leading, spacing: 4) {
                    Text("Şifre")
                        .font(.subheadline)
                        .fontWeight(.light)

                    SecureField("", text: $vm.password)
                        .padding(12)
                        .border(Color.gray, width: 1)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                }
                
                .padding(.bottom)

                Button(action: handleSignInButtonTap) {
                    Text("GİRİŞ YAP")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        
                }
                
                Button(action: {
                    // TODO: Implement
                    print("Şifremi Unuttum")
                }, label: {
                    Text("Şifremi Unuttum")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(4)
                })
            }
            .padding()
            .padding(.top)
            .border(Color.gray.opacity(0.4), width: 1)
            .padding(.horizontal)
        }
    }
    
    var registerSection: some View {
        Section {
            VStack(spacing: 10) {
                Text("ARAMIZA KATILMAK İSTER MİSİN?")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("Sipariş takibi, kolay iade ve daha fazlası için bir hesap oluşturun.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)
                    .padding(.bottom)
                
                NavigationLink {
                    SignUpView(vm: vm, showSignedInView: $showSignedInView, tabSelection: $tabSelection)
                        
                } label: {
                    Text("ÜYE OL")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .border(Color.accentColor, width: 1)
                }
               
            }
            .padding()
            .padding(.top)
            .border(Color.gray.opacity(0.4), width: 1)
            .padding(.horizontal)
        }
    }
}

extension SignInView {
    func handleSignInButtonTap() {
        Task {            
            do {
                if !checkIfInputIsValid() { return }
                try await vm.signIn()
                showSignedInView = false
                return
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
    
    func checkIfInputIsValid() -> Bool {
        if vm.email.isEmpty || vm.password.isEmpty {
            alertMessage = "Lütfen tüm alanları doldurunuz."
            showAlert = true
            return false
        }
        
        return true
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignedInView: .constant(false), tabSelection: .constant(5))
    }
}
