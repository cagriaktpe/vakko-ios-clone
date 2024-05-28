//
//  MyAddressesView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 27.05.2024.
//

import SwiftUI

struct MyAddressesView: View {
    var body: some View {
        ScrollView {
            addAddressButton
        }
        .padding(.horizontal)
        .navigationTitle("Adreslerim")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: addAddress) {
                    Image(systemName: "plus")
                }
                .fontWeight(.semibold)
            }
        }
    }
    
    var addAddressButton: some View {
        Button(action: addAddress) {
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
    func addAddress() {
    }
}

#Preview {
    NavigationStack {
        MyAddressesView()
    }
}
