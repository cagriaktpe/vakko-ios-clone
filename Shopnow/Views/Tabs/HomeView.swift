//
//  HomeView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    Image("man")
                        .resizable()
                        .scaledToFit()
                    
                    Image("woman")
                        .resizable()
                        .scaledToFit()
                    
                    Image("kid")
                        .resizable()
                        .scaledToFit()
                }
            }
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    HomeView()
}
