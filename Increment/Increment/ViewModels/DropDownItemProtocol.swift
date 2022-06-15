//
//  DropDownItemProtocol.swift
//  Increment
//
//  Created by Lusine on 5/20/22.
//

import Foundation

protocol  DropDownItemProtocol {
    var options: [DropDownOption] { get }
    var headerTittle: String { get }
    var dropDownTittle: String { get }
    var isSelected: Bool { get set }
    var selectedOption: DropDownOption {get set }
}

protocol DropDownOptionProtocol {
    var toDropDoownOption: DropDownOption { get }
}

struct DropDownOption {
    enum DropDownOptionType {
        case text(String)
        case number(Int)
    }
    let type: DropDownOptionType
    let formatted: String
}
