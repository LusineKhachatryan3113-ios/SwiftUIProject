//
//  AuthenticFireBaseApp.swift
//  Authentication
//
//  Created by Lusine on 5/6/22.
//

import SwiftUI
import Firebase

@main

struct SwiftUIFireBaseAuthApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            LoginView(viewModel: AppViewModel())
                .environmentObject(viewModel)
        }
        }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}

