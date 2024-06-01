//
//  BasketRowView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 1.06.2024.
//

import SwiftUI

struct BasketRowView: View {
    let selectedProduct: SelectedProductModel
    @Binding var quantity: Int

    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var cartViewModel: CartViewModel

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: selectedProduct.product.images.first ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 150)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 150)
            .border(Color.gray, width: 1)

            VStack(alignment: .leading) {
                Text(selectedProduct.product.title.uppercased())
                    .font(.headline)
                    .fontWeight(.regular)
                    .lineLimit(2)
                    .foregroundColor(.primary)

                Text("₺\(selectedProduct.product.price, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.accentColor)
                
                Text("Beden: \(selectedProduct.size)")
                    .padding(.vertical, 5)
                
                Picker("Adet", selection: $quantity) {
                    ForEach(1...10, id: \.self) { number in
                        Text("\(number) adet")
                            .tag(number)
                    }
                }
                .pickerStyle(.menu)
                .border(Color.gray, width: 1)
                .padding(.top, 10)
                

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .topTrailing) {
                Button(action: handleDiscardButtonClick) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 1)

            Spacer()
        }
        .padding()
    }
}

extension BasketRowView {
    func handleDiscardButtonClick() {
        cartViewModel.removeProduct(product: selectedProduct.product, size: selectedProduct.size)
    }

}
