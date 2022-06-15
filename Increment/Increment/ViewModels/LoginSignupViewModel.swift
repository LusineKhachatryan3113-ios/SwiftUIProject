//
//  LoginSignupViewModel.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//


import Combine
import SwiftUI

final class LoginSignupViewModel: ObservableObject {
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    @Binding var isPushed: Bool
    
    private(set) var emailPlaceholderText = "Email"
    private(set) var passwordPlaceholderText = "Pasword"
    
    private let userService: UserServiceProtocol
    private var cancellebles: [AnyCancellable] = []
    init(mode: Mode, userService: UserServiceProtocol = UserService(), isPushed: Binding<Bool>) {
        self.mode = mode
        self.userService = userService
        self._isPushed = isPushed
        
        Publishers.CombineLatest($emailText, $passwordText)
            .map { [weak self] email, password in
                return self?.isValidEmail(email) == true && self?.isValidPassword(password) == true
            }.assign(to: &$isValid)
    }
    
    var title: String {
        switch mode {
            case .login:
                return "Welcome back!"
            case .signup:
                return "Create an account"
        }
    }
    
    var subtitle: String {
        switch mode {
            case .login:
                return "log in with your email"
            case .signup:
                return "Sign up via email"

        }
    }
    
    var buttontitle: String {
        switch mode {
            case .login:
                return "log in"
            case .signup:
                return "Sign up"

        }
    }
    
    func tappedActionButton() {
        switch mode {
            case .login:
                userService.login(email: emailText, password: passwordText).sink { completion in
                    switch completion{
                        case let .failure(error):
                            print(error.localizedDescription)
                        case .finished: break
                            
                    }
                } receiveValue: { _ in }
                .store(in: &cancellebles)
            case .signup:
                userService.linkAccount(email: emailText, password: passwordText).sink { [weak self] completion in
                    switch completion {
                        case let .failure(error):
                            print(error.localizedDescription)
                        case .finished:
                            self?.isPushed = false
                            print("Finished")
                        
                    }
                } receiveValue: { _ in }
                .store(in: &cancellebles)

        }
    }
}

extension LoginSignupViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-Z]{2,64}"
        let emailPrad = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPrad.evaluate(with: email) && email.count > 5
    }
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 5
}
}
extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
