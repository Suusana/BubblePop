//
//  SettingView.swift
//  BubblePop
//
//  Created by susana on 2/4/2025.
//

import SwiftUI

struct SettingView:View {
    @EnvironmentObject var ViewModel: SettingViewModel
    var body: some View {
        ZStack{
            Color.yellow.opacity(0.3)
                .ignoresSafeArea()
            VStack{
                HStack{
                    goBackButton()
                        .padding(.trailing, 90)
                    Text("SETTINGS")
                        .font(.title)
                }.padding(.bottom,40)
                VStack{
                    
                    Text("Select the timer")
                        .pinkBG()
                    Picker("Select the timer",selection: $ViewModel.countDownTime){
                        ForEach([10,20,30,40,50,60],id: \.self){ time in
                            Text("\(time) seconds")
                        }
                    }.pickerStyle(.wheel)
                    
                    Text("Maximum Bubbles")
                        .pinkBG()
                    Picker("Maximum Bubbles",selection: $ViewModel.maxBubble){
                        ForEach(5...15, id: \.self){ bubble in
                            Text("\(bubble)")
                        }
                    }.pickerStyle(.wheel)
                }.font(.title2)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingView().environmentObject(SettingViewModel())
}
