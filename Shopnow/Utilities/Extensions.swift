//
//  Extensions.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 25.05.2024.
//

import Foundation
import SwiftUI

extension Date {
    func toStringMiddle() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}

extension PresentationDetent {
    static let bar = Self.custom(BarDetent.self)
    static let small = Self.height(200)
    static let extraLarge = Self.fraction(0.75)
}


private struct BarDetent: CustomPresentationDetent {
    static func height(in context: Context) -> CGFloat? {
        max(44, context.maxDetentValue * 0.1)
    }
}
