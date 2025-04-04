//
//  Buttons.swift
//  BubblePop
//
//  Created by susana on 2/4/2025.
//
import SwiftUI

// Encapsulated the menu buttons
struct MenuButton <Destination : View> : View {
    var title:String
    var icon:String
    var destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 24,height: 24)
                .padding(10)
            Text(title)
                .font(.title)
                .bold().frame(width: 250)
        }.mainButton()
        
    }
}

// The go back button
struct goBackButton : View {
    @Environment(\.dismiss) var back
    var body: some View {
        Button(action: {
            back()
        }, label: {
            HStack{
                Image(systemName: "chevron.left")
                Text("Back")
            }.bold()
                .frame(width: 100,height: 40)
                .mainButton()
        }).navigationBarBackButtonHidden()
    }
    
    
}
