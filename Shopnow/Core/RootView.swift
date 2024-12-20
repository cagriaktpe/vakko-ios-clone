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
                Text("Anasayfa")
            }
            .tag(0)
            .toolbarBackground(.white, for: .tabBar)

            NavigationStack {
                CategoriesView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Kategoriler")
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

            NavigationStack {
                BasketView(tabSelection: $tabSelection)
            }

            .tabItem {
                Image(systemName: "basket")
                Text("Sepet")
            }
            .tag(3)
            .toolbarBackground(.white, for: .tabBar)

            NavigationStack {
                ProfileView(showSignInView: $showSignInView, tabSelection: $tabSelection)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Hesabım")
            }
            .tag(4)
            .toolbarBackground(.white, for: .tabBar)
        }
    }
}

#Preview {
    RootView()
}
