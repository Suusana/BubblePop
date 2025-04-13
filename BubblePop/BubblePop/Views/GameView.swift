//
//  GameView.swift
//  BubblePop
//
//  Created by susana on 2/4/2025.
//

import SwiftUI

struct GameView:View {
    let playerName:String
    @StateObject var viewModel = GameViewModel()
    @StateObject var scoreViewModel : ScoreViewModel
    
    @State private var highestScore: Int = 0 // the highest score
    
    @State private var poppedBubbles: Set<UUID> = [] // record the popped bubbles's id, used for animation
    
    @State private var scoreText: String = "" // floating score text eg:"+1" "+2"...
    @State private var showScore = false // whether to show the floating score animation
    
    var body: some View {
        NavigationStack{
            if viewModel.isOver {
                //if the game is over, then show the game over page
                OverView(scoreViewModel: scoreViewModel, score: viewModel.score, name: playerName)
            } else{
                ZStack {
                    Color.orange.opacity(0.2).ignoresSafeArea()
                    
                    // before starting, display 3-2-1-Go
                    if viewModel.isCountingDown {
                        ZStack{
                            Color.white.opacity(0.5).ignoresSafeArea()
                            Text(viewModel.countdown == 0 ? "GO!" : "\(viewModel.countdown)")
                                .font(.largeTitle).bold()
                                .scaleEffect(6)
                                .foregroundColor(.mint)
                                .animation(.easeInOut, value: viewModel.countdown)
                        }.zIndex(100)
                    }
                    
                    ForEach(viewModel.bubbles) { bubble in
                        Image(bubble.color)
                            .resizable()
                            .frame(width: radius * 2, height: radius * 2)
                            .position(bubble.position)
                            .scaleEffect(poppedBubbles.contains(bubble.id) ? 1.5 : 1.0)
                            .opacity(poppedBubbles.contains(bubble.id) ? 0 : 1)
                            .animation(.easeInOut(duration: 0.3), value: poppedBubbles)
                            .onTapGesture {
                                // to get the actual score,eg: score x1.5
                                let actualScore = viewModel.popBubble(bubble: bubble)
                                scoreText = "+\(actualScore)"
                                showScore = true

                                // showing floating score for 0.3 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    showScore = false
                                }

                                // showing the animation of bubble for 0.3 seconds
                                poppedBubbles.insert(bubble.id)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    poppedBubbles.remove(bubble.id)
                                }
                            }


                    }

                    VStack {
                        // display the timer and score
                        HStack {
                            Text("Time: \(viewModel.timeRemain)")
                            Spacer()
                            VStack{
                                Text("Your Score: \(viewModel.score)")
                                Text("Highest Score: \(highestScore)")
                            }.onAppear(){
                                // if there is no record, then display the highest score as 0
                                highestScore = scoreViewModel.records.first?.score ?? 0
                            }
                        }
                        .padding()
                        .background(.white.opacity(0.5))
                        .font(.headline)
                        // showing eg: "+1" "+2"... animation
                        if showScore {
                            Text(scoreText)
                                .font(.largeTitle).bold()
                                .foregroundColor(.mint)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                                .animation(.easeOut(duration: 0.8), value: showScore)
                                .zIndex(100)
                        }
                        Spacer()
                    }
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .navigationBarBackButtonHidden()
                    .onAppear {
                        //generate bubbles when this page appear
                        viewModel.bubbles = generateBubbles(count: viewModel.maxBubbles, existing: [])
                        
                        // after 1-2-3-Go animation ends, then start the timer, refresh bubbles and let bubbles go up
                        viewModel.BeforeStart(){
                            viewModel.countDown()
                            viewModel.refreshBubbles()
                            viewModel.GoUP()
                        }
                    }.onChange(of: viewModel.score) {
                        // if current score is higher than the highest score, then display current score as the highest
                        if $1 > highestScore {
                            highestScore = $1
                        }
                    }
            }
        }
    }
}

#Preview {
    GameView(playerName: "Guest", scoreViewModel: ScoreViewModel()).environmentObject(SettingViewModel())
}
