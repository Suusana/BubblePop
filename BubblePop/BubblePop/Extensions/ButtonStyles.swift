//
//  ButtonStyles.swift
//  BubblePop
//
//  Created by susana on 2/4/2025.
//

import SwiftUI

extension View {
    // The most common used type of button style
    func mainButton() -> some View {
        foregroundColor(.brown)
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.brown, lineWidth: 5))
    }
}
