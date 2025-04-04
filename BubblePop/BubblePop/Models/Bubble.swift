//
//  Bubble.swift
//  BubblePop
//
//  Created by susana on 3/4/2025.
//
import SwiftUI

// bubbles information
struct Bubble : Identifiable, Equatable{
    var id = UUID()
    var color: String
    var score: Int
    var position: CGPoint
}
