//
//  GameViewModel.swift
//  BubblePop
//
//  Created by susana on 3/4/2025.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject{
    @Published var bubbles:[Bubble] = [] // store an Array of bubbles
    @Published var score:Int = 0
    
    @Published var timeRemain:Int // The remaining time for game page
    @Published var isOver = false // check if the game is over
    
    @Published var maxBubbles:Int // store the maximum bubble number
    
    @Published var isCountingDown = true
    @Published var countdown: Int = 3 // timer number for 3-2-1-Go animation
    
    private var lastBublle:String? = nil // store tha last bubble that user popped
    
    private var timer : Timer? // timer for game page
    private var refreshTimer:Timer? // timer for refresh bubbles
    private var upTimer: Timer? // timer for bubbles going up
    
    var screenHeight = UIScreen.main.bounds.height // the screens height
    var speed: CGFloat = 0.5 // the default speed for all bubbles
    
    init(timeRemain:Int = 60, maxBubbles:Int = 15){
        self.timeRemain = timeRemain
        self.maxBubbles = maxBubbles
    }
    
    // the count down timer function for game page
    func countDown(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemain > 0{
                self.timeRemain -= 1
            } else{
                self.isOver = true
                self.timer?.invalidate()
                self.refreshTimer?.invalidate()
                self.upTimer?.invalidate()
            }
        }
    }
    
    // the refresh bubbles function
    func refreshBubbles() {
        refreshTimer?.invalidate()

        // refresh every 2 seconds
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            DispatchQueue.main.async {
                // remove random number of bubbles
                let remove = Int.random(in: 1...(self.maxBubbles))
                if self.bubbles.count >= remove {
                    self.bubbles.removeLast(remove)
                } else {
                    self.bubbles.removeAll()
                }
                
                //calculate the available bubble numbers
                let availableNum = self.maxBubbles - self.bubbles.count
                // add random bubbles number
                let addNum = availableNum > 0 ? Int.random(in: 1...availableNum) : 0

                if addNum > 0 {
                    // get the existing bubbles position
                    let existingPoints = self.bubbles.map { $0.position }
                    // generate new bubbles
                    let newBubbles = generateBubbles(count: addNum, existing: existingPoints)
                    // add new bubbles
                    self.bubbles.append(contentsOf: newBubbles)
                }
            }
        }
    }
    
    // fucntion when player pop bubbles
    func popBubble(bubble:Bubble) -> Int{
        var Score = bubble.score
        // to see if the current popped bubble has same color with the last bubble
        if bubble.color == lastBublle {
            Score = Int((Double(Score) * 1.5).rounded())
        }
        score += Score
        // remove the bubble popped
        bubbles.removeAll(){$0.id == bubble.id}
        
        // record the current bubble as the last bubble
        lastBublle = bubble.color
        return Score
    }
    
    // function for 3-2-1-Go animation
    func BeforeStart(completion: @escaping () -> Void) {
        countdown = 3
        isCountingDown = true
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countdown > 1 {
                self.countdown -= 1
            } else {
                timer.invalidate()
                self.countdown = 0
                // after this animation ends, then start other function
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isCountingDown = false
                    completion()
                }
            }
        }
    }
    
    //function for bubble going up
    func GoUP() {
        upTimer?.invalidate()
        upTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.updateBubbles()
        }
    }

    // function for updating bubbles positions
    func updateBubbles() {
        for i in (0..<bubbles.count).reversed() {
            bubbles[i].position.y -= speed

            if bubbles[i].position.y <= screenHeight / 17 {
                bubbles.remove(at: i)
            }
        }

        speed += 0.01
    }
}
