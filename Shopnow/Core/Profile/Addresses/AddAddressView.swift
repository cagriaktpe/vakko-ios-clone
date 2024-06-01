//
//  AddAddressView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 27.05.2024.
//

import SwiftUI

struct AddAddressView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ProfileViewModel
    
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
    
    @State private var showAddressTypePicker: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var isSuccessful: Bool = false

    var body: some View {
        ScrollView {
            formSection
        }
        .navigationTitle("YENİ ADRES EKLE")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .sheet(isPresented: $showAddressTypePicker) {
            NavigationStack {
                addressTypePicker
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Tamam") {
                                showAddressTypePicker.toggle()
                            }
                        }
                    }
            }
            .presentationDetents([.height(150)])

        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam"), action: {
                if isSuccessful {
                    dismiss()
                }
            }))
        }
    }
}

// MARK: - Subviews
extension AddAddressView {
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
                showAddressTypePicker.toggle()
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


// MARK: - Functions
extension AddAddressView {
    func checkFieldsEmpty() -> Bool {
        if title.isEmpty || name.isEmpty || surname.isEmpty || city.isEmpty || district.isEmpty || neighborhood.isEmpty || postCode.isEmpty || address.isEmpty || phoneNumber.isEmpty {
            setAlert(title: .error, message: "Lütfen tüm alanları doldurun.")
            return false
        }
        
        return true
    }
    
    func save() {
        
        guard checkFieldsEmpty() else { return }
        
        let address = AddressModel(addressType: addressType, title: title, name: name, surname: surname, city: city, district: district, neighborhood: neighborhood, postCode: postCode, address: address, phoneNumber: phoneNumber)
        
        Task {
            do {
                try await viewModel.addAddress(address: address)
                setAlert(title: .success, message: "Adres başarıyla eklendi.")
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
    NavigationStack {
        AddAddressView()
            .environmentObject(ProfileViewModel())
    }
}
