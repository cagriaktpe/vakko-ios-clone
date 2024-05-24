//
//  ContentView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct LandingView: View {
    
    @State var showSignInView: Bool = false
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Shopnow")
            }
            .toolbarBackground(.white, for: .tabBar)

            CategoriesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Menü")
                }
                .toolbarBackground(.white, for: .tabBar)

            FavoriesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorilerim")
                }
                .toolbarBackground(.white, for: .tabBar)

            BasketView()
                .tabItem {
                    Image(systemName: "basket")
                    Text("Sepetim")
                }
                .toolbarBackground(.white, for: .tabBar)

            NavigationStack {
                ProfileView(showSignInView: $showSignInView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profilim")
            }
            .toolbarBackground(.white, for: .tabBar)
        }
    }
}

#Preview {
    LandingView()
}
