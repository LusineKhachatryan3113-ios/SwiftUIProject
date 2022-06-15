//
//  ContentView.swift
//  Increment
//
//  Created by Lusine on 5/19/22.
//

import SwiftUI

struct LandingView: View {
    @StateObject private var viewModel = LandingViewModel()
    
    var title: some View {
        Text (viewModel.title)
            .font(.system(size: 64, weight: .medium))
            .foregroundColor(.white)
    }
    
    var createButton: some View {
        Button(action: {
            viewModel.createdPushed = true
        }) {

            HStack(spacing: 15) {
                Spacer()
                Image(systemName: viewModel.createButtonImageName)
                    .font(.system(size: 24,weight: .semibold))
                    .foregroundColor(.white)
                Text(viewModel.createButtonTitle)
                    .font(.system(size: 24,weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
        }.padding(15)
        .buttonStyle(PrimaryButtonStyle())
    }
    
    var alreadyButton: some View {
        Button(viewModel.alreadyButtonTittle) {
            viewModel.loginSignupPushed = true
        }.foregroundColor(.white)
    }
    
    var backgroundImage: some View {
        Image(viewModel.backgroundImageName)
            .resizable()
            .aspectRatio(contentMode: .fill
            )
    .overlay(Color.black.opacity(0.4))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.08)
                    title
                    Spacer()
                    NavigationLink(destination: CreateView(), isActive: $viewModel.createdPushed) {}
                        createButton
                    NavigationLink(destination: LoginSignupView(viewModel: .init(mode: .login, isPushed: $viewModel.loginSignupPushed)),
                                   isActive: $viewModel.loginSignupPushed) {}
                    alreadyButton
                    
                }.padding(.bottom, 15)
                .frame(maxWidth: .infinity,
                         maxHeight: .infinity)
                .background(
                 backgroundImage
                 .frame(width: proxy.size.width)
                 .edgesIgnoringSafeArea(.all)
                )
            }
        } .accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone8")
        LandingView().previewDevice("iPhone11 Pro")
        LandingView().previewDevice("iPhone11 Pro Max")
    }
}

