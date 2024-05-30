//
//  ProductListView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject var vm: ProductsViewModel
    
    let category: String
    let subCategory: String
    
    var body: some View {
        List {
            ForEach(vm.products) { product in
                NavigationLink(destination: Text("Product Detail")) {
                    ProductRow(product: product)
                }
                .onAppear {
                    print(product.title ?? "N/A")
                }
            }
        }
        .onAppear {
            print(vm.products)
        }
    }
}

struct ProductRow: View {
    let product: ProductModel
    
    var body: some View {
        HStack {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
                Text(product.title ?? "N/A")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("\(product.price ?? 0)")
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    ProductListView(vm: ProductsViewModel(), category: CategoryType.woman.rawValue, subCategory: WomanSubCategoryType.dress.rawValue)
}
