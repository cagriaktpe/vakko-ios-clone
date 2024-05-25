//
//  SignUpView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 25.05.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var vm: AuthenticationViewModel
    
    @Binding var showSignedInView: Bool
    @Binding var tabSelection: Int
    
    @State private var showDatePicker = false
    @State private var firstCheckBox = false
    @State private var secondCheckBox = false
    @State private var thirdCheckBox = false
    @State private var fourthCheckBox = false
    @State private var fifthCheckBox = false
    
    
    var body: some View {
        ScrollView {
            signInSection
        }
        .navigationTitle("Üye Ol")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension SignUpView {
    var signInSection: some View {
        Section {
            VStack(spacing: 12) {
                nameRow
                surnameRow
                phoneNumberRow
                emailRow
                passwordRow
                birthDayRow
                    .padding(.bottom, 5)
                agreementPart
                signUpButton
                .padding(.bottom)
            }
            .padding()
            .padding(.top)
            .border(Color.gray.opacity(0.4), width: 1)
            .padding(.horizontal)
        }
    }
    
    var nameRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Ad")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("", text: $vm.name)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.default)
                .autocapitalization(.words)
                .textContentType(.name)
                .disableAutocorrection(true)
        }
    }
    
    var surnameRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Soyad")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("", text: $vm.surname)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.default)
                .autocapitalization(.words)
                .textContentType(.familyName)
                .disableAutocorrection(true)
        }
    }
    
    var phoneNumberRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Telefon")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("0 (555) 555 55 55", text: $vm.phoneNumber)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.phonePad)
                .autocapitalization(.none)
                .textContentType(.telephoneNumber)
                .disableAutocorrection(true)
        }
    }
    
    var emailRow: some View {
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
    }
    
    var passwordRow: some View {
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
    }
    
    var birthDayRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Doğum Tarihi")
                .font(.subheadline)
                .fontWeight(.light)

            Button {
                showDatePicker.toggle()
            } label: {
                HStack {
                    Text(vm.birthDate == nil ? "Seçiniz" : vm.birthDate!.toStringMiddle())
                        .foregroundStyle(Color.primary)
                        .fontWeight(.light)
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline)
                }
                .padding(12)
                .border(Color.gray, width: 1)
            }
        }
    }
    
    var agreementPart: some View {
        VStack(spacing: 36) {
            Text("Üyelik olmadan önce lütfen Aydınlatma Metni'ni okuyunuz. Aydınlatma metnine her zaman bu link'ten veya mobil uygulama üzerinden ulaşabilirsiniz.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                
            
            Toggle(isOn: $firstCheckBox) {
                Text("Shopnow Tekstil ve Hazır Giyim San. İşi A.Ş. tarafından kampanya ve ürünler hakkında E-posta ile tarafımla iletişim kurulmasına izin veriyorum.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.primary)
            .toggleStyle(iOSCheckboxToggleStyle())
            
            Toggle(isOn: $secondCheckBox) {
                Text("Shopnow Tekstil ve Hazır Giyim San. İşi A.Ş. tarafından kampanya ve ürünler hakkında SMS ile tarafımla iletişim kurulmasına izin veriyorum.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.primary)
            .toggleStyle(iOSCheckboxToggleStyle())
            
            Toggle(isOn: $thirdCheckBox) {
                Text("Shopnow Tekstil ve Hazır Giyim San. İşi A.Ş. tarafından kampanya ve ürünler hakkında telefon ile tarafımla iletişim kurulmasına izin veriyorum.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.primary)
            .toggleStyle(iOSCheckboxToggleStyle())
            
            Toggle(isOn: $fourthCheckBox) {
                Text("Üyelik Sözleşmesi'ni okudum ve kabul ediyorum.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.primary)
            .toggleStyle(iOSCheckboxToggleStyle())
            
            Toggle(isOn: $fifthCheckBox) {
                Text("Açık Rıza Metni'ni okudum, onaylıyorum.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.primary)
            .toggleStyle(iOSCheckboxToggleStyle())
            

                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    var signUpButton: some View {
        Button {
            Task {
                do {
                    try await vm.signUp()
                    showSignedInView = false
                    return
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } label: {
            Text("ÜYE OL")
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

#Preview {
    NavigationStack {
        SignInView(showSignedInView: .constant(false), tabSelection: .constant(5))
    }
}
