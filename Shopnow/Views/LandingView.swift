//
//  ContentView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Anasayfa")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Arama")
                }
            
            MenuView()
                .tabItem {
                    Image(systemName: "line.horizontal.3")
                    Text("Menü")
                }
            
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Sepetim")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profilim")
                }
        }
    }
}

#Preview {
    LandingView()
}
