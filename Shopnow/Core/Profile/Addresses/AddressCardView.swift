//
//  AddressCardView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 28.05.2024.
//

import SwiftUI

struct AddressCardView: View {
    @ObservedObject var vm: ProfileViewModel
    
    // TODO: FIX
    @State private var isPreferred: Bool = false
    
    let address: AddressModel

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text(address.title.uppercased())
                    .lineLimit(1)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(y: 12)

                Toggle(isOn: $isPreferred, label: {
                    Text("Varsayılan")
                        .font(.headline)
                        .fontWeight(isPreferred ? .bold : .regular)
                        .multilineTextAlignment(.leading)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                
                .foregroundStyle(.primary)
                .toggleStyle(iOSCheckBoxToggleStyle2())

                Text("ADRES")
                    .lineLimit(1)
                
                Text("\(address.district) \(address.city)")
                    .lineLimit(1)
                
                Text(address.phoneNumber)
                    .lineLimit(1)
            }
            .padding(.horizontal)
            .padding(.top)

            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)

            HStack {
                Button(action: deleteAddress) {
                    Text("Adresi Sil")

                }

                Spacer()

                Button(action: editAddress) {
                    Text("Adresi Düzenle")
                }
            }
            .fontWeight(.semibold)
            .padding(.horizontal, 30)
            .padding(.top, 5)
            .padding(.bottom)
        }
        .border(Color.secondary.opacity(0.5), width: 1)
        .padding(.vertical)
        .overlay {
            VStack {
                Circle()
                    .strokeBorder(Color.primary, lineWidth: isPreferred ? 2 : 1)
                    .background(Circle().fill(.white))
                    .frame(width: 58, height: 58)
                    .overlay {
                        Text("1")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                
                Spacer()
            }
            .offset(y: -20)
        }
        .onAppear {
            isPreferred = vm.user?.preferredAddressId == address.id ? true : false
        }
        .onChange(of: isPreferred) { _ in
            
        }
    }
}

extension AddressCardView {
    func deleteAddress() {
    }
    
    func editAddress() {
    }
}

#Preview {
    
    let testAddress = AddressModel(addressType: .home, title: "Ev", name: "Samet", surname: "Aktepe", city: "İstanbul", district: "Beyoğlu", neighborhood: "Karaköy", postCode: "34000", address: "Karaköy Mahallesi, Kemeraltı Caddesi, No: 5", phoneNumber: "5534513358")
    
    return AddressCardView(vm: ProfileViewModel(), address: testAddress)
}
