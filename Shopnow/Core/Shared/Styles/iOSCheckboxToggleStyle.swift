//
//  iOSCheckboxToggleStyle.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 1.06.2024.
//

import SwiftUI

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
