//
//  Backgroud.swift
//  BubblePop
//
//  Created by susana on 4/4/2025.
//

import SwiftUI

struct catBackground:View {
    var body: some View {
        // backround
        Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

