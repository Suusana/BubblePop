//
//  BubblesView.swift
//  BubblePop
//
//  Created by susana on 3/4/2025.
//
import SwiftUI

// store the bubbles radius
var radius:CGFloat {
    UIScreen.main.bounds.width / 8
}

// generate bubbles position
func generatePoints(count: Int, existing: [CGPoint] = []) -> [CGPoint] {
    var points: [CGPoint] = []
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let topSafe:CGFloat = screenHeight / 17 // make sure that all bubble with not be covered by top score and timer
    
    let padding: CGFloat = 4 // padding between each bubbles
    for _ in 0..<count {
        var attempt = 0 // make sure that the game view will not get stuck
        var newPoint: CGPoint?

        while newPoint == nil && attempt < 100 {
            attempt += 1
            let x = CGFloat.random(in: radius...(screenWidth - radius))
            let y = CGFloat.random(in: (radius+topSafe)...(screenHeight - radius))
            let point = CGPoint(x: x, y: y)

            // to see if bubbles positions generated overlaps
            let overlaps = (points + existing).contains { existing in
                let dx = point.x - existing.x
                let dy = point.y - existing.y
                let distance = sqrt(dx * dx + dy * dy)
                return distance < (radius * 2 + padding)
            }
            // if not overlapping, then add this bubbles position
            if !overlaps {
                newPoint = point
            }
        }

        if let point = newPoint {
            points.append(point)
        }
    }
    return points
}

// generate bubbles functions
func generateBubbles(count: Int, existing: [CGPoint] = []) -> [Bubble] {
    let positions = generatePoints(count: count, existing: existing)
    var bubbles: [Bubble] = []

    for pos in positions {
        let randomNum = Int.random(in: 1...100)
        let (color, score): (String, Int)

        // different color of bubbles have different score and posibility of apperance
        switch randomNum {
        case 1...40:
            (color, score) = ("red", 1)
        case 41...70:
            (color, score) = ("pink", 2)
        case 71...85:
            (color, score) = ("green", 5)
        case 86...95:
            (color, score) = ("blue", 8)
        default:
            (color, score) = ("black", 10)
        }

        let bubble = Bubble(color: color, score: score, position: pos)
        bubbles.append(bubble)
    }

    return bubbles
}

