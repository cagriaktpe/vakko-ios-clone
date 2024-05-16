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
                    HomeCardView(title: "İLKBAHAR/YAZ '24", image: "Man-Woman-Home")
                    HomeCardView(title: "KADIN", image: "Woman-Home")
                    HomeCardView(title: "ERKEK", image: "Man-Home")
                }
            }
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity)
        }
    }
}

struct HomeCardView: View {
    let title: String
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(height: 330)
            .overlay {
                Text(title)
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5)
            }
    }
}

#Preview {
    HomeView()
}
