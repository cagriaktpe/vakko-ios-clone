//
//  MyAddressesView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 27.05.2024.
//

import SwiftUI

struct MyAddressesView: View {
    @EnvironmentObject var viewModel: ProfileViewModel

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            addAddressButton
                .padding(.bottom, 28)

            if let addresses = viewModel.user?.addresses {
                VStack(spacing: 28) {
                    ForEach(addresses) { address in
                        AddressCardView(
                            address: address,
                            isPreferred: Binding(get:
                                { checkIfPreferred(address: address) },
                                set: { _ in
                                    setPreferredAddress(addressId: address.id)
                                }),
                            showAlert: $showAlert,
                            alertTitle: $alertTitle,
                            alertMessage: $alertMessage
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("ADRESLERİM")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AddAddressView()) {
                    Image(systemName: "plus")
                }
                .fontWeight(.semibold)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }

    var addAddressButton: some View {
        NavigationLink(destination: AddAddressView()) {
            Text("Yeni Adres Ekle")
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

extension MyAddressesView {
    func checkIfPreferred(address: AddressModel) -> Bool {
        return viewModel.user?.preferredAddressId == address.id
    }

    func setPreferredAddress(addressId: String) {
        Task {
            do {
                try await viewModel.setPreferredAddress(addressId: addressId)
            } catch {
                makeAlert(title: "Hata", message: "Adres tercih edilemedi.")
            }
        }
    }

    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}

#Preview {
    NavigationStack {
        MyAddressesView()
            .environmentObject(ProfileViewModel())
    }
}
