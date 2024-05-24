//
//  ProductModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 15.05.2024.
//

import Foundation

struct ProductModel: Identifiable {
    
    var id = UUID().uuidString
    var mainImage: String
    var images: [String]
    var title: String
    var description: String
    var price: String
    var isNewCollection: Bool
    var sizes: [String]
   
}

