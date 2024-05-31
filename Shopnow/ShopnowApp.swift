//
//  ShopnowApp.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import Firebase
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ShopnowApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var profileViewModel: ProfileViewModel = ProfileViewModel()
    @StateObject var productsViewModel = ProductsViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(profileViewModel)
                .environmentObject(productsViewModel)
                .task {
                    try? await profileViewModel.loadCurrentUser()
                }
        }
    }
}
