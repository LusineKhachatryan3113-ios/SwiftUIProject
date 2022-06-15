//
//  SettingsViewModel.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//

import Combine
import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemViewModels:[SettingsItemViewModel] = []
    @Published var loginSignupPushed = false
    let title = "Settings"
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    init (userService:UserServiceProtocol = UserService()){
        self.userService = userService
    }
            
            
            
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
            case .account:
                guard userService.currentUser?.email == nil else { return }
                loginSignupPushed = true
//            case .mode:
//                isDarkMode = !isDarkMode
//                buildItems()
            case .logout:
                userService.logout().sink { completion in
                    switch completion {
                        case let .failure(error):
                            print(error.localizedDescription)
            case .finished: break
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)
            default:
                break
            
        }
    }
    
    private func buildItems() {
        itemViewModels = [
            .init(title: userService.currentUser?.email ?? "Create Account", iconName: "person.circle",type: .account),
           // .init(title: "Switch to \(isDarkMode ? "Light" : "Dark") Light Mode", iconName: "lightbulb", type: .account),
            .init(title: "Privacy Policy", iconName: "shield", type: .account)
        ]
        
        if userService.currentUser?.email != nil {
            itemViewModels += [.init(title: "LogOut", iconName: "arrowsshape.turn.up.left" , type: .logout)]
        }
    }
    
    func onAppear() {
        buildItems()
    }
}
