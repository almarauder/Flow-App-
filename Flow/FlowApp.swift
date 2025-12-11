//
//  FlowApp.swift
//  Flow
//
//  Created by Darking Almas on 07.11.2025.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct FlowApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate 
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Configure set")
        
    return true
  }
}
