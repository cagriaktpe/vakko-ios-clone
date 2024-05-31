//
//  UpdateEmailView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 27.05.2024.
//

import SwiftUI

struct UpdateEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm: ProfileViewModel
    
    @Binding var showSignedInView: Bool
    @Binding var tabSelection: Int
    
    @State private var newEposta: String = ""
    @State private var newEpostaAgain: String = ""
    @State private var password: String = ""
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                accountSection
            }
            .padding(.top)
        }
        .navigationTitle("E posta Güncelle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam"), action: {
                dismiss()
            }))
                
        }
    }
}

extension UpdateEmailView {
    var accountSection: some View {
        Section {
            VStack(spacing: 0) {
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Yeni E postanız")
                            .font(.subheadline)
                            .fontWeight(.light)

                        TextField("", text: $newEposta)
                            .padding(12)
                            .border(Color.gray, width: 1)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                    }
                    

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Yeni E posta Tekrar")
                            .font(.subheadline)
                            .fontWeight(.light)

                        TextField("", text: $newEpostaAgain)
                            .padding(12)
                            .border(Color.gray, width: 1)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Şifreniz")
                            .font(.subheadline)
                            .fontWeight(.light)

                        SecureField("", text: $password)
                            .padding(12)
                            .border(Color.gray, width: 1)
                            .textContentType(.password)
                            .disableAutocorrection(true)
                            .keyboardType(.default)
                    }

                }
                saveButton

            }
            
            .padding()
            .padding(.top)
            .border(Color.gray.opacity(0.4), width: 1)
            .padding(.horizontal)
        }
    }
    
    var saveButton: some View {
        Button(action: save) {
            Text("KAYDET")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
        }
        .padding(.top, 24)
    }
}

extension UpdateEmailView {
    func save() {
        guard !newEposta.isEmpty else {
            alertTitle = "Hata"
            alertMessage = "Lütfen yeni e postanızı giriniz."
            showAlert = true
            return
        }
        
        guard !newEpostaAgain.isEmpty else {
            alertTitle = "Hata"
            alertMessage = "Lütfen yeni e postanızı tekrar giriniz."
            showAlert = true
            return
        }
        
        guard newEposta == newEpostaAgain else {
            alertTitle = "Hata"
            alertMessage = "Girdiğiniz e postalar birbirleri ile uyuşmuyor."
            showAlert = true
            return
        }
        
        guard !password.isEmpty else {
            alertTitle = "Hata"
            alertMessage = "Lütfen şifrenizi giriniz."
            showAlert = true
            return
        }
        
        Task {
            do {
                try await vm.updateEmail(newEmail: newEposta, password: password)
                alertTitle = "Başarılı"
                alertMessage = "E posta adresiniz başarıyla güncellendi."
                showAlert = true
            } catch {
                alertTitle = "Hata"
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        UpdateEmailView(showSignedInView: .constant(false), tabSelection: .constant(5))
    }
}
