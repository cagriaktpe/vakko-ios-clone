//
//  AddressModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 28.05.2024.
//

import Foundation

enum AddressType: String, CaseIterable, Codable {
    case home = "Bireysel"
    case work = "Kurumsal"
}


struct AddressModel: Codable, Identifiable {
    var id = UUID().uuidString
    let addressType: String
    let title: String
    let name: String
    let surname: String
    let city: String
    let district: String
    let neighborhood: String
    let postCode: String
    let address: String
    let phoneNumber: String
    
    init(
        addressType: AddressType,
        title: String,
        name: String,
        surname: String,
        city: String,
        district: String,
        neighborhood: String,
        postCode: String,
        address: String,
        phoneNumber: String
    ) {
        self.addressType = addressType.rawValue
        self.title = title
        self.name = name
        self.surname = surname
        self.city = city
        self.district = district
        self.neighborhood = neighborhood
        self.postCode = postCode
        self.address = address
        self.phoneNumber = phoneNumber
    }
    
    init() {
        self.addressType = AddressType.home.rawValue
        self.title = ""
        self.name = ""
        self.surname = ""
        self.city = ""
        self.district = ""
        self.neighborhood = ""
        self.postCode = ""
        self.address = ""
        self.phoneNumber = ""
    }
}
