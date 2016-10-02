//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    var currentColor = ""
    var currentPatternColor = ""
    
    @IBAction func redButton(_ sender: AnyObject) {
        simonSaysGame.guessRed()
        //badChoice()
        buttonsClicked += 1
        checkWin()
    }
    
    @IBAction func greenButton(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        //badChoice()
        buttonsClicked += 1
        checkWin()
    }
    
    @IBAction func yellowButton(_ sender: AnyObject) {
        simonSaysGame.guessYellow()
        //badChoice()
        buttonsClicked += 1
        checkWin()
    }
    
    @IBAction func blueButton(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        //badChoice()
        buttonsClicked += 1
        checkWin()
            }
    
    func checkWin() {
        if buttonsClicked == simonSaysGame.numberOfColorsToMatch {
            switch simonSaysGame.wonGame() {
            case true:
                winLabel.text = "You won"
                winLabel.isHidden = false
                startGameButton.isHidden = false
                buttonsClicked = 0
                simonSaysGame = SimonSays()
            default:
                winLabel.text = "Nope, try again."
                winLabel.isHidden = false
                startGameButton.isHidden = false
                buttonsClicked = 0
                simonSaysGame = SimonSays()
            }
        }
    }
    
    func badChoice() {
        currentColor = simonSaysGame.chosenColors[buttonsClicked].description
        currentPatternColor = simonSaysGame.patternToMatch[buttonsClicked].description
        switch currentColor != currentPatternColor {
        case true:
            simonSaysGame.tryAgainWithTheSamePattern()
            winLabel.text = "Nope, try again."
            displayTheColors()
        default:
            winLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.isHidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        winLabel.isHidden = true
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
