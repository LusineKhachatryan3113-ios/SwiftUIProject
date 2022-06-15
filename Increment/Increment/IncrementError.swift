//
//  IncrementError.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//

import Foundation

enum IncrementError: LocalizedError {
    case auth(description: String)
    case `default` (description: String? = nil)
    
    var errorDescription: String? {
        switch self {
            case let .auth(description):
            return description
            case let .default(description):
                
            return description ?? "Something went wrong"
        }
    }
}
