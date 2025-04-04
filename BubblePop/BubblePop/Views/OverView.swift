//
//  OverView.swift
//  BubblePop
//
//  Created by susana on 3/4/2025.
//

import SwiftUI

struct OverView : View {
    @EnvironmentObject var settingViewModel: SettingViewModel
    @ObservedObject var scoreViewModel = ScoreViewModel()
    
    let score: Int
    let name: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                // backround
                catBackground()
                
                VStack {
                    // display the user's name and score
                    Text("Game Over")
                        .foregroundStyle(.purple)
                    Text("Congratulations!")
                        .padding(.top,50)
                    Text("Your name: \(name)")
                    Text("Your score is: \(score)")
                        .padding(.bottom,50)

                    // buttons
                    VStack (spacing: 20){
                        MenuButton(title: "RESTART",
                                   icon: "gobackward",
                                   destination: GameView(
                                    playerName: name,
                                    viewModel: GameViewModel(
                                        timeRemain: settingViewModel.countDownTime,
                                        maxBubbles: settingViewModel.maxBubble)))
                        
                        MenuButton(title: "SCOREBOARD", icon: "trophy.fill",destination: ScoreView())
                        
                        MenuButton(title: "BACK TO MENU", icon: "house.fill",destination: MenuView())
                    }
                    Spacer()
                }.font(.largeTitle).bold()
                    .foregroundStyle(.brown)
                    .onAppear(){
                        // when this page appear, record the user's name and score
                        scoreViewModel.addRecord(name: name, score: score)
                    }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    OverView(score: 0, name: "suwuwwwu").environmentObject(SettingViewModel())
}
