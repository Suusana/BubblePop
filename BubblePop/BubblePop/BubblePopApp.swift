//
//  BubblePopApp.swift
//  BubblePop
//
//  Created by Susana on 2/4/2025.
//

import SwiftUI

@main
struct BubblePopApp: App {
    @StateObject var setting = SettingViewModel()
    var body: some Scene {
        WindowGroup {
            MenuView().environmentObject(setting)
        }
    }
}
