//
//  LoginView.swift
//  Authentication
//
//  Created by Lusine on 5/6/22.
//

import SwiftUI
import Firebase


class FirebaseManager: NSObject {
    
    let auth: Auth
    static let shared = FirebaseManager()
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        super.init()
    }
}

struct LoginView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode,label:
                            Text("Picker here")) {
                            Text("Login")
                                .tag(true)
                            Text("Create Account")
                                .tag(false)
                        }.pickerStyle(SegmentedPickerStyle())
                    
                    if !isLoginMode {
                       Button {

                    } label: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 64))
                            .padding()
                    }
                    }

                    Group {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .keyboardType(.numbersAndPunctuation)
                        .autocapitalization(.none)
                   
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack{
                            Spacer()
                            Text(isLoginMode ? "Log In" :"Create Account")
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                        Spacer()
                            
                        }.background(Color.blue)
                    }
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(Color.red)
                    
                    
                }
                .padding()
               
                
    }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
   }
        .navigationViewStyle(StackNavigationViewStyle())
 }
    
    private func handleAction() {
        if isLoginMode {
            print("Should log into Firebase with existig credentials")
            loginUser()
        } else {
            createNewAccount()
           print("Register a new account inside of Firebase Auth and then store image in Storage somehow...")
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { (result, err) in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        
        }
        
    }
    
    @State var loginStatusMessage = ""
    
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
        }
    }
}
    
struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}







