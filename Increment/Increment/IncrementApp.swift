//
//  IncrementApp.swift
//  Increment
//
//  Created by Lusine on 5/19/22.
//

import SwiftUI
import Firebase


@main
struct IncrementApp: App {
  
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn{
                TabContainerView()
            } else {
                LandingView()
        
        }
    }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
class AppState: ObservableObject {
    
    @Published private(set) var isLoggedIn = false
    
    private let userServce: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userServce = userService
        try? Auth.auth().signOut()
        userService
            .observeAuthChanges()
            .map {$0 != nil}
            .assign(to: &$isLoggedIn)
    }
}
