//
//  FloatScore.swift
//  BubblePop
//
//  Created by Susana on 3/4/2025.
//

import SwiftUI

// the floating score information on the top of game view
struct FloatScore: Identifiable, Equatable {
    let id = UUID()
    let score: Int
    let position: CGPoint
}
