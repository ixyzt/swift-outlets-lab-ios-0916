//
//  SimonSaysGame.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

enum Color: Int {
    case red, green, yellow, blue
}

// MARK: - UIColor Display
extension Color {
    var colorToDisplay: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .green:
            return UIColor.green
        case .yellow:
            return UIColor.yellow
        case .blue:
            return UIColor.blue
        }
    }
}


// MARK: - CustomStringConvertible Protocol
extension Color: CustomStringConvertible {
    var description: String {
        switch self {
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .yellow:
            return "Yellow"
        case .blue:
            return "Blue"
        }
    }
}


struct SimonSays {
    
    var chosenColors = [Color]()
    var patternToMatch = [Color]()
    var colorToDisplay = 0
    let numberOfColorsToMatch: Int
    
    // initializes SimonSays with 5 as the number of colors to match
    init(numberOfColorsToMatch: Int = 5) {
        self.numberOfColorsToMatch = numberOfColorsToMatch
    // for the each count of toMatch, creates a random number between 1 and 4 and passes that to Color which checks it against it's switch, then it adds that string to the  patternToMatch array.
        for _ in (0..<numberOfColorsToMatch) {
            let randomNumber = Int(arc4random_uniform(4))
            let randomColor = Color(rawValue: randomNumber)!
            patternToMatch.append(randomColor)
        }
    }
}


// MARK: - Gameplay methods
extension SimonSays {

    mutating func nextColor() -> Color? {
        var color: Color? = nil
        if colorToDisplay < patternToMatch.count {
            color = patternToMatch[colorToDisplay]
        }
        colorToDisplay += 1
        return color
    }

    func sequenceFinished() -> Bool {
        return colorToDisplay > patternToMatch.count
    }

    func wonGame() -> Bool {
        return chosenColors == patternToMatch
    }
    
    fileprivate mutating func makeGuessWith(_ color: Color) -> Bool {
        guard chosenColors.count < patternToMatch.count else { return false }
        chosenColors.append(color)
        return patternToMatch[chosenColors.count - 1] == color
    }

    mutating func guessRed() {
        makeGuessWith(.red)
    }
    
    mutating func guessGreen() {
        makeGuessWith(.green)
    }
    
    mutating func guessYellow() {
        makeGuessWith(.yellow)
    }
    
    mutating func guessBlue() {
        makeGuessWith(.blue)
    }
    
    mutating func tryAgainWithTheSamePattern() {
        chosenColors.removeLast()
        // display the colors in order again to the user (up to the turn)
    }
}
