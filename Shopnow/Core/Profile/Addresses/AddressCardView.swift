//
//  AddressCardView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 28.05.2024.
//

import SwiftUI

struct AddressCardView: View {
    @State private var isPreferred: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("EV")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)

                Toggle(isOn: $isPreferred, label: {
                    Text("Varsayılan")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.primary)
                .toggleStyle(iOSCheckBoxToggleStyle2())

                Text("ADRES")
                Text("BEYOĞLU İSTANBUL-AVRUPA")
                Text("5534513358")
            }
            .padding(.horizontal)
            .padding(.top)

            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)

            HStack {
                Button {
                } label: {
                    Text("Adresi Sil")
                }

                Spacer()

                Button {
                } label: {
                    Text("Adresi Düzenle")
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }

        .border(Color.secondary.opacity(0.5), width: 1)
        .padding()
    }
}

#Preview {
    AddressCardView()
}
