//
//  GroceryStoreFirebaseApp.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/23/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GroceryStoreFirebaseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
