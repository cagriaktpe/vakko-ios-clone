//
//  CategoryModel.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 15.05.2024.
//

import Foundation

enum Category: Int, CaseIterable {
    
    
    case men = 0
    case women = 1
    
    private var cases: [String] {
        
        ["Men", "Women"]
    }
    
    func toString() -> String {
        
        cases[self.rawValue]
    }
}

