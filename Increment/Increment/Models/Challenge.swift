//
//  Challenge.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//

import Foundation

struct Challenge: Codable, Hashable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
