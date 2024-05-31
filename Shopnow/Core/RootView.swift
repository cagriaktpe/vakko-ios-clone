//
//  RootView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

struct RootView: View {
    @State var showSignInView: Bool = false
    @State private var tabSelection = 0

    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Shopnow")
            }
            .tag(0)
            .toolbarBackground(.white, for: .tabBar)

            NavigationStack {
                CategoriesView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Menü")
            }
            .tag(1)
            .toolbarBackground(.white, for: .tabBar)

            NavigationStack {
                FavoriesView(tabSelection: $tabSelection)
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorilerim")
            }
            .tag(2)
            .toolbarBackground(.white, for: .tabBar)
            
                

            BasketView()
                .tabItem {
                    Image(systemName: "basket")
                    Text("Sepetim")
                }
                .tag(3)
                .toolbarBackground(.white, for: .tabBar)

            NavigationStack {
                ProfileView(showSignInView: $showSignInView, tabSelection: $tabSelection)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profilim")
            }
            .tag(4)
            .toolbarBackground(.white, for: .tabBar)
        }
    }
}

#Preview {
    RootView()
}
