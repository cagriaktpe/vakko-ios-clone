//
//  ProductDetailView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: ProductModel
    
    var body: some View {
        ScrollView {
            VStack {
                images
                firstSection
                Divider()
                sizeSection
                Divider()
            }
            
        }
        .navigationTitle(product.title?.uppercased() ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

extension ProductDetailView {
    var images: some View {
        TabView {
            ForEach(product.images ?? [], id: \.self) { image in
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 600)
        .shadow(radius: 5)
    }
    
    var firstSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title?.uppercased() ?? "")
                    .font(.title2)
                    .foregroundStyle(.primary)
                
                Text("₺\(product.price ?? 0, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
                
            }
            
            Spacer()
            
            Button {
                // Add to Cart
            } label: {
                Image(systemName: "heart.fill")
                    .font(.title)
                    .foregroundStyle(Color.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
    
    var sizeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Beden")
                    .font(.body)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text("Beden Tablosu")
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            
            HStack(spacing: 20) {
                ForEach(product.sizes ?? [], id: \.self) { size in
                    Button {
                        // Select Size
                    } label: {
                        Text(size)
                            .font(.callout)
                            .padding(12)
                            .foregroundStyle(Color.primary)
                            .border(Color.primary, width: 1)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)

    }
}

#Preview {
    NavigationStack {
        ProductDetailView(product: ProductModel(id: 1, thumbnail: "https://i.ibb.co/D9JYsjV/orange-forward.jpg", images: ["https://i.ibb.co/D9JYsjV/orange-forward.jpg", "https://i.ibb.co/GsmsHzN/orange-back.jpg"], title: "Turuncu Elbise", description: "Description", price: 100, sizes: ["34", "36", "38", "40", "42"]))
    }
}
