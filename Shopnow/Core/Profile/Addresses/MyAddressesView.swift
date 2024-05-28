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
            addressRow
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
    
    var addressRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("EV")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("ADRES")
            Text("BEYOĞLU İSTANBUL-AVRUPA")
            Text("5534513358")
        }
        .padding(.vertical, 8)
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
