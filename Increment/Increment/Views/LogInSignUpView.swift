//
//  LogInSignUpView.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//

import SwiftUI


struct LoginSignupView: View {
    
    @ObservedObject var viewModel: LoginSignupViewModel
    
  
    
    var emailTextField: some View {
        TextField(viewModel.emailPlaceholderText, text: $viewModel.emailText)
            .modifier(TextFieldRoundedStyle())
            .autocapitalization(.none)
    }
    var passwordTexField: some View {
        SecureField(viewModel.passwordPlaceholderText,text: $viewModel.passwordText)
            .modifier(TextFieldRoundedStyle())
            .autocapitalization(.none)
    }
    
    var actionButton: some View {
        Button(viewModel.buttontitle) {
        
            viewModel.tappedActionButton()
            
        }.padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(.systemPink))
        .cornerRadius(16)
        .padding()
        .disabled(!viewModel.isValid)
        .opacity(viewModel.isValid ? 1 : 0.4)
    }
    
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(viewModel.subtitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            Spacer()
                .frame(height: 50)
            emailTextField
            passwordTexField
            actionButton
            Spacer()
        }.padding()
    }

}
struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
       // LoginSignupView(viewModel: .init(mode: .login.isPushed, isPushed: $viewModel.loginSignupPushed))
      //  LoginSignupView(viewModel: .init(mode: .login,isPushed: $viewModel.loginSignupPushed))
        }
}
}


