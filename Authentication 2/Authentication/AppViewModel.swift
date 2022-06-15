//
//  AppViewModel.swift
//  Authentication
//
//  Created by Lusine on 5/12/22.
//


import SwiftUI
import FirebaseAuth
import Combine

typealias UserID = String

enum Action {
    //case selectOption(index: Int)
    case createChallnge
}

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
//    func signIn(email: String, password: String) {
//        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
//        guard result != nil, error == nil  else {
//            return
//        }
//            DispatchQueue.main.async {
//                // Success
//                    self?.signedIn = true
//            }
//
//        }
//    }
//
//
    
    func send(action: Action) {
        switch action  {
            case .createChallnge:
                currentUserId().sink { completion in
                    switch completion {
                        case let .failure(error):
                            print(error.localizedDescription)
                        case .finished:
                            print("completed")
                    }
                } receiveValue: { userId in
                    print("retrieved userId = \(userId)")
                }.store(in: &cancellables)
             }
        
    }
     
     func currentUserId() -> AnyPublisher<UserID, Error> {
        print("getting userid")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserID, Error> in
            if let userId = user?.uid {
                print("user is loged in...")
                return Just(userId)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is loged in Anonymously...")
              return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
        
    }

    
//    func signUp(email: String, password: String) {
//        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
//            guard result != nil, error == nil  else {
//                return
//            }
//            DispatchQueue.main.async {
//                // Success
//                    self?.signedIn = true
//            }
//        }
//    }
    func signOut() {
        try? auth.signOut()
    self.signedIn = false
    }
}

