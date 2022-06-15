//
//  LoginView.swift
//  Authentication
//
//  Created by Lusine on 5/6/22.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
  @StateObject var viewModel: AppViewModel
  @State var email = ""
  @State var password = ""
    var body: some View {
        
        NavigationView {
            if viewModel.signedIn {
                VStack {
                Text("You are signed in")
                Button (action: {
                    viewModel.signOut()
                }, label:{
                    Text("Sign Out")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.blue)
                        .padding()
                })

                }
            } else {
                SignInView(viewModel: AppViewModel())
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
        }
struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @StateObject var viewModel: AppViewModel
    
   var body: some View {
   
            VStack {
                TextField("Email Address", text: $email)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                SecureField("Email Address", text: $password)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                Button (action: {
                    
                    viewModel.send(action: .createChallnge)
                    
                    }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                })
                
                NavigationLink("Creat Account", destination: SignUpView( viewModel: AppViewModel()))
                    .padding()
            }
            .padding()
            Spacer()
        }
    
}


struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @StateObject  var viewModel: AppViewModel
    
   var body: some View {
   
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                SecureField("Email Address", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                Button (action: {
//
//                    guard !email.isEmpty, !password.isEmpty else {
//                        return
//                    }
                    viewModel.currentUserId()
                    
                    }, label: {
                    Text("Creat Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.blue)
                })
            }
            .padding()
            Spacer()
        }
    //.navigationTitle("Creat Account")
}


   

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: AppViewModel())
    }
}

}
