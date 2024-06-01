//
//  iOSCheckBoxToggleStyle2.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 1.06.2024.
//

import SwiftUI


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
                        if configuration.isOn {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(configuration.isOn ? Color.accentColor : .gray)
                        }
                    }
                configuration.label
            }
        })
    }
}
