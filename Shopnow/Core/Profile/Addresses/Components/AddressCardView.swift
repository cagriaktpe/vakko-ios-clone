//
//  AddressCardView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 28.05.2024.
//

import SwiftUI

struct AddressCardView: View {
    @EnvironmentObject var vm: ProfileViewModel
    
    let address: AddressModel
    
    // TODO: FIX
    @Binding var isPreferred: Bool
    
    

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
                .allowsHitTesting(isPreferred ? false : true)
                
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

                NavigationLink(destination: UpdateAddressView(addressToUpdate: address)) {
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
    }
}

extension AddressCardView {
    func deleteAddress() {
        Task {
            do {
                try await vm.deleteAddress(address: address)
            } catch {
                // TODO: Handle error
                print(error)
            }
        }
    }
}

#Preview {
    return (AddressCardView(address: AddressModel.dummyData, isPreferred: .constant(false))
        .environmentObject(ProfileViewModel()))
}
