//
//  ScoreView.swift
//  BubblePop
//
//  Created by susana on 2/4/2025.
//

import SwiftUI

struct ScoreView:View {
    @ObservedObject var viewModel = ScoreViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                Text("SCOREBOARD")
                    .font(.title).bold()
                    .foregroundStyle(.brown)
                
                // List all the records
                List{
                    ForEach(viewModel.records){ record in
                        HStack {
                            Text("\(record.name)")
                            Spacer()
                            Text("\(record.score)")
                        }
                    }
                }
                
                // back to menu button
                MenuButton(title: "BACK TO MENU", icon: "house.fill",destination: MenuView())
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    ScoreView()
}

