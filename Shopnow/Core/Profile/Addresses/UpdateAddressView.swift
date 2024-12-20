//
//  UpdateAddressView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 29.05.2024.
//

import SwiftUI

struct UpdateAddressView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ProfileViewModel
    
    let addressToUpdate: AddressModel
    
    @State private var addressType: AddressType = .home
    @State private var title: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var city: String = ""
    @State private var district: String = ""
    @State private var neighborhood: String = ""
    @State private var postCode: String = ""
    @State private var address: String = ""
    @State private var phoneNumber: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var isSuccessful: Bool = false
    
    var body: some View {
        ScrollView {
            formSection
        }
        .navigationTitle("ADRESİ DÜZENLE")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .onAppear {
            addressType = AddressType(rawValue: addressToUpdate.addressType) ?? .home
            title = addressToUpdate.title
            name = addressToUpdate.name
            surname = addressToUpdate.surname
            city = addressToUpdate.city
            district = addressToUpdate.district
            neighborhood = addressToUpdate.neighborhood
            postCode = addressToUpdate.postCode
            address = addressToUpdate.address
            phoneNumber = addressToUpdate.phoneNumber
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam"), action: {
                if isSuccessful {
                    dismiss()
                }
            }))
        }
    }

    var formSection: some View {
        VStack(spacing: 12) {
            selectAddressTypeRow
            selectTitleRow
            selectNameRow
            selectSurnameRow
            selectCityRow
            selectDistrictRow
            selectNeighborhoodRow
            selectPostCodeRow
            selectAddressRow
            selectPhoneNumberRow
            saveButton
                .padding(.bottom)
        }
        .padding()
        .padding(.top)
        .border(Color.gray.opacity(0.4), width: 1)
        .padding(.horizontal)
    }

    var selectAddressTypeRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Address")
                .font(.subheadline)
                .fontWeight(.light)

            Button(action: {
            }, label: {
                HStack {
                    Text(addressType.rawValue)
                        .tint(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.headline)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .border(Color.gray, width: 1)
            })
        }
    }
    
    var selectTitleRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Adres Başlığı")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("", text: $title)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.default)
                .autocapitalization(.words)
                .textContentType(.name)
                .disableAutocorrection(true)
        }
    }
    
    var selectNameRow: some View {
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
    }
    
    var selectSurnameRow: some View {
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
    }
    
    var selectCityRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Şehir")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("", text: $city)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.default)
                .autocapitalization(.words)
                .textContentType(.addressCity)
                .disableAutocorrection(true)
        }
    }
    
    var selectDistrictRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("İlçe")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("", text: $district)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.default)
                .autocapitalization(.words)
                .textContentType(.addressCity)
                .disableAutocorrection(true)
        }
    }
    
    var selectNeighborhoodRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Mahalle")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("", text: $neighborhood)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.default)
                .autocapitalization(.words)
                .textContentType(.addressCity)
                .disableAutocorrection(true)
        }
    }
    
    var selectPostCodeRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Posta Kodu")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("", text: $postCode)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.numberPad)
                .textContentType(.postalCode)
                .disableAutocorrection(true)
        }
    }
    
    var selectAddressRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Adres")
                .font(.subheadline)
                .fontWeight(.light)

            TextEditor(text: $address)
                .frame(height: 100, alignment: .leading)
                .border(Color.gray, width: 1)
                .keyboardType(.default)
                .autocapitalization(.words)
                .textContentType(.fullStreetAddress)
                .disableAutocorrection(true)
        }
    }
    
    var selectPhoneNumberRow: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Cep Telefonu")
                .font(.subheadline)
                .fontWeight(.light)

            TextField("0 (555) 555 55 55", text: $phoneNumber)
                .padding(12)
                .border(Color.gray, width: 1)
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
                .disableAutocorrection(true)
        }
    }

    var addressTypePicker: some View {
        Picker("Adres Tipi", selection: $addressType) {
            ForEach(AddressType.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.wheel)
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

extension UpdateAddressView {
    func checkFields() -> Bool {
        if title.isEmpty || name.isEmpty || surname.isEmpty || city.isEmpty || district.isEmpty || neighborhood.isEmpty || postCode.isEmpty || address.isEmpty || phoneNumber.isEmpty {
            setAlert(title: .error, message: "Lütfen tüm alanları doldurun.")
            return false
        }
        
        return true
    }
    
    func save() {
        
        guard checkFields() else { return }
        
        let newAddress = AddressModel(id: addressToUpdate.id, addressType: addressType, title: title, name: name, surname: surname, city: city, district: district, neighborhood: neighborhood, postCode: postCode, address: address, phoneNumber: phoneNumber)
        
        Task {
            do {
                try await viewModel.updateAddress(addressToUpdate: addressToUpdate, newAddress: newAddress)
                setAlert(title: .success, message: "Adres başarıyla güncellendi.")
            } catch {
                setAlert(title: .error, message: error.localizedDescription)
            }
        }
    }
    
    func setAlert(title: AlertType, message: String) {
        alertTitle = title.rawValue
        alertMessage = message
        showAlert = true
        
        if title == .success {
            isSuccessful = true
        } else {
            isSuccessful = false
        }
    }
}

#Preview {
    
    let addressToUpdate = AddressModel(addressType: .home, title: "Ev", name: "Samet", surname: "Aktepe", city: "İstanbul", district: "Beyoğlu", neighborhood: "Karaköy", postCode: "34000", address: "Karaköy Mahallesi, Kemeraltı Caddesi, No: 5", phoneNumber: "5534513358")
    
    return NavigationStack {
        UpdateAddressView(addressToUpdate: addressToUpdate)
    }
}
