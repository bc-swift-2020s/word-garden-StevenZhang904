//
//  ViewController.swift
//  Word Garden
//
//  Created by 张泽华 on 2020/1/31.
//  Copyright © 2020 张泽华. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessedLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "SWIFT"
    var letterGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessedLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text=""
    }
    func formatUserGuessLabel(){
        
               var revealedWord = ""
               letterGuessed += guessedLetterField.text!
               for letter in wordToGuess{
                   if letterGuessed.contains(letter){
                       revealedWord = revealedWord + "\(letter)"
                   }else{
                       revealedWord += " _"
                   }
               }
               
               userGuessLabel.text = revealedWord
    }
    
    func guessALetter(){
        formatUserGuessLabel()
        guessCount += 1
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower"+"\(wrongGuessesRemaining)")
        }
        let revealedWord = userGuessLabel.text!
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterButton.isEnabled = false
            guessedLetterField.isEnabled = false
            guessCountLabel.text="Sorry, you have ran out of guesses. Do you want to try again?"
            
        }else if !revealedWord.contains("_"){
            playAgainButton.isHidden = false
            guessedLetterButton.isEnabled = true
            guessedLetterField.isEnabled = false
            guessCountLabel.text = "You've made it! It took you \(guessCount) guesses to guess the word!"
        }else{
            let guess = (guessCount == 1 ? "guess" : "guesses")
//            var guess = "guesses"
//            if guessCount == 1 {
//                guess = "guesses"
//            }
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        print("Hey! The guessedLetterFieldChanged!!!")
        if let letterGuessed = guessedLetterField.text?.last{
            guessedLetterField.text = "\(letterGuessed)"
            guessedLetterButton.isEnabled = true

        }else{
            guessedLetterButton.isEnabled = false
        }
    }
     
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
      updateUIAfterGuess()
        
    }
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
       updateUIAfterGuess()
        

    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = false
        guessedLetterButton.isEnabled = true
        guessedLetterField.isEnabled = true
        flowerImageView.image = UIImage(named:"flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        letterGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses."
        guessCount = 0
    }
    
}

