//
//  ProductModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    var id: Int
    var thumbnail: String?
    var images: [String]?
    var title: String?
    var description: String?
    var price: Double?
    var sizes: [String]?
    var category: String? // man or woman
    var subCategory: String?
    var care: String?
    var exchange: String?
   
    
   
    
}
