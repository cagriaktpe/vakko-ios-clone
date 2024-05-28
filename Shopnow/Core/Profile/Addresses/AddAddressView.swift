//
//  AddAddressView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 27.05.2024.
//

import SwiftUI

enum AddressType: String, CaseIterable {
    case home = "Bireysel"
    case work = "Kurumsal"
}

struct AddAddressView: View {
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

    var body: some View {
        ScrollView {
            formSection
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
                .padding(12)
                .padding(.vertical, 24)
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

extension AddAddressView {
    func save() {
    }
}

#Preview {
    AddAddressView()
}
