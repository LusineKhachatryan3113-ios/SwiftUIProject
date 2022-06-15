//
//  AppDelegateAdaptor.swift
//  ChatAppStreamSwftUI
//
//  Created by Lusine on 5/14/22.
//

import SwiftUI
import StreamChat
import StreamChatUI

class AppDelegate1: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupStream()
        return true
    }
    
    func setupStream() {
        let config = ChatClientConfig(apiKey: .init(Setup.apikey))
        let token: Token = Token(stringLiteral: Setup.token)
        
        ChatClient.shared = ChatClient(config: config)
        applyChatCustomizations()
        
        ChatClient.shared.connectUser(userInfo: UserInfo(id: Setup.userId, name: Setup.userName), token: token)
    }
    
    func applyChatCustomizations() {
        Appearance.default.colorPalette.background6 = .green
        Appearance.default.images.sendArrow = UIImage(systemName: "arrowshape.turn.up.right")!
        Components.default.channelVC = ChannelViewController.self
    }
}
