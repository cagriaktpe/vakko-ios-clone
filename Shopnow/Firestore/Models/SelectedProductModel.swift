//
//  CartModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import Foundation

struct SelectedProductModel: Codable, Hashable {
    var product: ProductModel
    var size: String
    var quantity: Int
}

extension SelectedProductModel {
    static let example1 = SelectedProductModel(product: ProductModel.mockData[0], size: "M", quantity: 1)
    static let example2 = SelectedProductModel(product: ProductModel.mockData[1], size: "M", quantity: 1)
}
