//
//  LandingViewModel.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//

import Foundation

final class LandingViewModel: ObservableObject {
    @Published var loginSignupPushed = false
    @Published var createdPushed = false
    
    
    let title = "Increment"
    let createButtonTitle = "Create a challenge"
    let createButtonImageName = "plus.circle"
    let alreadyButtonTittle = "I already have an account"
    let backgroundImageName = "pullups"
}
