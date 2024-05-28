//
//  Utilities.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 24.05.2024.
//

import Foundation
import UIKit
import SwiftUI

final class Utilities {
    
    static let shared = Utilities()
    
    private init() {}
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack(alignment: .top) {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(configuration.isOn ? Color.accentColor : .gray)
            
                configuration.label
            }
        })
    }
}

struct iOSCheckBoxToggleStyle2: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack(alignment: .top) {
                
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.secondary.opacity(0.5))
                    .overlay {
                        Image(systemName: configuration.isOn ? "circle.fill" : "circle")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(configuration.isOn ? Color.accentColor : .gray)
                    }
                configuration.label
            }
        })
    }
}
