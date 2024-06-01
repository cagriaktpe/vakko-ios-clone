//
//  MyAccountView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 27.05.2024.
//

import SwiftUI

struct MyAccountView: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var vm: ProfileViewModel

    @Binding var showSignedInView: Bool
    @Binding var tabSelection: Int

    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var phoneNumber: String = ""

    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                accountSection
                deleteAccountButton
            }
            .padding(.top)
        }
        .navigationTitle("Hesabım")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam"), action: {
                if alertMessage != "Bir şey değişmedi" {
                    dismiss()
                }
            }))
        }
        .onAppear {
            name = vm.user?.name ?? ""
            surname = vm.user?.surname ?? ""
            phoneNumber = vm.user?.phoneNumber ?? ""
        }
    }
}

extension MyAccountView {
    var accountSection: some View {
        Section {
            VStack(spacing: 0) {
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Ad")
                            .font(.subheadline)
                            .fontWeight(.light)

                        TextField("", text: $name)
                            .padding(12)
                            .border(Color.gray, width: 1)
                            .keyboardType(.default)
                            .autocapitalization(.words)
                            .textContentType(.name)
                            .disableAutocorrection(true)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Soyad")
                            .font(.subheadline)
                            .fontWeight(.light)

                        TextField("", text: $surname)
                            .padding(12)
                            .border(Color.gray, width: 1)
                            .keyboardType(.default)
                            .autocapitalization(.words)
                            .textContentType(.familyName)
                            .disableAutocorrection(true)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Telefon")
                            .font(.subheadline)
                            .fontWeight(.light)

                        TextField("0 (555) 555 55 55", text: $phoneNumber)
                            .padding(12)
                            .border(Color.gray, width: 1)
                            .keyboardType(.phonePad)
                            .autocapitalization(.none)
                            .textContentType(.telephoneNumber)
                            .disableAutocorrection(true)
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

    var deleteAccountButton: some View {
        Button(action: deleteAccount) {
            Text("Hesabımı Sil")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
        .padding(.leading)
    }
}

extension MyAccountView {
    func save() {
        if name == vm.user?.name && surname == vm.user?.surname && phoneNumber == vm.user?.phoneNumber {
            makeAlert(title: "Hata", message: "Bir şey değişmedi")
            return
        }

        vm.updateUser(newName: name, newSurname: surname, newPhoneNumber: phoneNumber)
        makeAlert(title: "Başarılı", message: "Hesabınız başarıyla güncellendi.")
    }

    func deleteAccount() {
        Task {
            do {
                try await vm.deleteAccount()
                makeAlert(title: "Başarılı", message: "Hesabınız başarıyla silindi.")
                showSignedInView = true
            } catch {
                makeAlert(title: "Hata", message: "Hesabınız silinirken bir hata oluştu.")
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
        MyAccountView(showSignedInView: .constant(false), tabSelection: .constant(5))
            .environmentObject(ProfileViewModel())
    }
}
