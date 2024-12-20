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
    var id: String
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
        id: String = UUID().uuidString,
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
        self.id = id
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
        self.id = UUID().uuidString
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

extension AddressModel {
    static let dummyData = AddressModel(
        id: "1",
        addressType: .home,
        title: "Ev",
        name: "Samet Çağrı",
        surname: "Aktepe",
        city: "İstanbul",
        district: "Ümraniye",
        neighborhood: "Çakmak",
        postCode: "34770",
        address: "Çakmak Mah. 123. Sok. No: 4",
        phoneNumber: "5555555555"
    )
}
