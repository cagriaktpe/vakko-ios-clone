//
//  MyAddressesView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 27.05.2024.
//

import SwiftUI

struct MyAddressesView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ScrollView {
            addAddressButton
                .padding(.bottom, 28)

            if let addresses = viewModel.user?.addresses {
                VStack(spacing: 28) {
                    ForEach(addresses) { address in
                        AddressCardView(vm: viewModel, address: address)
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Adreslerim")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AddAddressView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
                .fontWeight(.semibold)
            }
        }
    }

    var addAddressButton: some View {
        NavigationLink(destination: AddAddressView(viewModel: viewModel)) {
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

#Preview {
    NavigationStack {
        MyAddressesView(viewModel: ProfileViewModel())
    }
}
