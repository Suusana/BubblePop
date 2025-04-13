//
//  ContentView.swift
//  BubblePop
//
//  Created by Susana on 2/4/2025.
//

import SwiftUI

struct MenuView: View {
    @State private var name = ""; // user input name
    @EnvironmentObject var settingViewModel : SettingViewModel
    @StateObject private var scoreViewModel = ScoreViewModel()

    var body: some View {
        NavigationStack{
            ZStack{
                //background
                catBackground()
                
                // Title TextInput and buttons
                VStack {
                    Spacer()
                    Text("Bubble Pop")
                    Text("Game").padding(.bottom,40)
                    
                    Text("Please enter your name")
                        .font(.title3)
                    TextField("Eg: Lily",text: $name)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                        .font(.title3)
                        .padding(.bottom,50)
                    
                    // Buttons
                    VStack(spacing: 20){
                        MenuButton(title: "START GAME", icon: "play.fill",destination: {
                            // if the name is empty then use guest as the player's name
                            let finalName = name.isEmpty ? "Guest" : name
                            return GameView(
                                playerName: finalName,
                                viewModel: GameViewModel(
                                    timeRemain: settingViewModel.countDownTime,
                                    maxBubbles: settingViewModel.maxBubble
                                ),
                                scoreViewModel: scoreViewModel
                            )
                        }()
                        )
                        MenuButton(title: "SCOREBOARD", icon: "trophy.fill",destination: ScoreView())
                        
                        MenuButton(title: "SETTINGS", icon: "hammer.fill",destination: SettingView().environmentObject(settingViewModel))
                    }
                    Spacer()
                    
                }.font(.system(size: 52, weight: .heavy, design: .rounded))
                    .foregroundStyle(.brown)
            }.navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    MenuView().environmentObject(SettingViewModel())
}

