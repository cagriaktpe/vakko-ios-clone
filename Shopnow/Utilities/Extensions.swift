//
//  Extensions.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 25.05.2024.
//

import Foundation

extension Date {
    func toStringMiddle() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
