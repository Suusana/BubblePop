//
//  SettingViewModel.swift
//  BubblePop
//
//  Created by susana on 3/4/2025.
//
import SwiftUI

class SettingViewModel: ObservableObject{
    @Published var countDownTime:Int = 60 // timer for game page, default value is 60
    @Published var maxBubble:Int = 15 // maximum bubbles for game page, default value is 15
}
