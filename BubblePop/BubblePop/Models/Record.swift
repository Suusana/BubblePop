//
//  Record.swift
//  BubblePop
//
//  Created by susana on 3/4/2025.
//

import SwiftUI

// the players information
struct Record : Identifiable,Codable{
    var id = UUID()
    var name:String
    var score:Int
}
