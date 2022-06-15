//
//  SwiftUIStreamChatApp.swift
//  ChatAppStreamSwftUI
//
//  Created by Lusine on 5/14/22.
//

import SwiftUI

@main
 
struct SwiftUIStreamChatApp:App {
    
    @UIApplicationDelegateAdaptor(AppDelegate1.self) var appDelegate
    
    var body: some Scene{
        WindowGroup {
            NavigationView {
                ChannelListView()
                    .ignoresSafeArea()
            }
        }
    }
}
