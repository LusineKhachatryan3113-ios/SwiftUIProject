//
//  SettingsItemViewModel.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//

import Foundation

extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title: String
        let iconName: String
        let type: SettingsItemtype
      
    }
    
    enum SettingsItemtype {
        case account
        case mode
        case privacy
        case logout
    }
}
