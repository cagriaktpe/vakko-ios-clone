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
        VStack(spacing: 0) {
            VStack(spacing: 12) {
                newEmailSection
                againEmailSection
                passwordSection
            }
            saveButton
        }
        .padding()
        .padding(.top)
        .border(Color.gray.opacity(0.4), width: 1)
        .padding(.horizontal)
    }

    var newEmailSection: some View {
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
    }

    var againEmailSection: some View {
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
    }

    var passwordSection: some View {
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
            makeAlert(title: "Hata", message: "Lütfen yeni e postanızı giriniz.")
            return
        }

        guard !newEpostaAgain.isEmpty else {
            makeAlert(title: "Hata", message: "Lütfen yeni e postanızı tekrar giriniz.")
            return
        }

        guard newEposta == newEpostaAgain else {
            makeAlert(title: "Hata", message: "Girdiğiniz e postalar birbirleriyle uyuşmuyor.")
            return
        }

        guard !password.isEmpty else {
            makeAlert(title: "Hata", message: "Lütfen şifrenizi giriniz.")
            return
        }

        Task {
            do {
                try await vm.updateEmail(newEmail: newEposta, password: password)
                makeAlert(title: "Başarılı", message: "E posta adresiniz başarıyla güncellendi.")
            } catch {
                alertTitle = "Hata"
                alertMessage = error.localizedDescription
                showAlert = true
            }
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
        UpdateEmailView(showSignedInView: .constant(false), tabSelection: .constant(5))
            .environmentObject(ProfileViewModel())
    }
}
