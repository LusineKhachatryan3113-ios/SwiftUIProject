//
//  ChannelListView.swift
//  ChatAppStreamSwftUI
//
//  Created by Lusine on 5/14/22.
//

import StreamChat
import StreamChatUI
import SwiftUI


struct ChannelListView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ChannelListViewController
    
    func makeUIViewController(context: Context) -> ChannelListViewController {
        let channelList = ChannelListViewController()
        let query = ChannelListQuery(filter: .containMembers(userIds: [Setup.userId]))
        channelList.controller = ChatClient.shared.channelListController(query: query)
        return channelList
    }
    
    
    func updateUIViewController(_ uiViewController: ChannelListViewController, context: Context) {
        
    }
    
}
