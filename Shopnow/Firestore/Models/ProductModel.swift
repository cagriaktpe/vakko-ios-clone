//
//  ProductModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    var id: Int
    var thumbnail: String
    var images: [String]
    var title: String
    var description: String
    var price: Double
    var sizes: [String]
    var category: String // man or woman
    var subCategory: String
    var careDetail: String
    var exchangeDetail: String
    
    init(id: Int, thumbnail: String, images: [String], title: String, description: String, price: Double, sizes: [String], category: String, subCategory: String, careDetail: String, exchangeDetail: String) {
        self.id = id
        self.thumbnail = thumbnail
        self.images = images
        self.title = title
        self.description = description
        self.price = price
        self.sizes = sizes
        self.category = category
        self.subCategory = subCategory
        self.careDetail = careDetail
        self.exchangeDetail = exchangeDetail
    }
   
    // coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case thumbnail
        case images
        case title
        case description
        case price
        case sizes
        case category
        case subCategory = "sub_category"
        case careDetail = "care_detail"
        case exchangeDetail = "exchange_detail"
    }
    
    // encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(images, forKey: .images)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(price, forKey: .price)
        try container.encode(sizes, forKey: .sizes)
        try container.encode(category, forKey: .category)
        try container.encode(subCategory, forKey: .subCategory)
        try container.encode(careDetail, forKey: .careDetail)
        try container.encode(exchangeDetail, forKey: .exchangeDetail)
    }
    
    // decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        images = try container.decode([String].self, forKey: .images)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        price = try container.decode(Double.self, forKey: .price)
        sizes = try container.decode([String].self, forKey: .sizes)
        category = try container.decode(String.self, forKey: .category)
        subCategory = try container.decode(String.self, forKey: .subCategory)
        careDetail = try container.decode(String.self, forKey: .careDetail)
        exchangeDetail = try container.decode(String.self, forKey: .exchangeDetail)
    }
    
}
