//
//  TextFieldRoundedStyle.swift
//  Increment
//
//  Created by Lusine on 5/22/22.
//

import SwiftUI

struct TextFieldRoundedStyle: ViewModifier  {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.primary)
            .padding()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 16
                ).stroke(
                    Color.primary
                )
            )
            .padding(.horizontal,15)
    }
}

