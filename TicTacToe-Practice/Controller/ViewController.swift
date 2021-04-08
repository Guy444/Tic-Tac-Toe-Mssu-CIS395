//
//  ViewController.swift
//  TicTacToe-Practice
//
//  Created by Borchert, Otto on 2/22/20.
//  Copyright © 2020 Borchert, Otto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var upperLeft: UIImageView!
    @IBOutlet var upperMiddle: UIImageView!
    @IBOutlet var upperRight: UIImageView!
    @IBOutlet var centerLeft: UIImageView!
    @IBOutlet var centerMiddle: UIImageView!
    @IBOutlet var centerRight: UIImageView!
    @IBOutlet var bottomLeft: UIImageView!
    @IBOutlet var bottomMiddle: UIImageView!
    @IBOutlet var bottomRight: UIImageView!

    var images: [[UIImageView]]? = nil

    var ticTacToe = TicTacToeBoard()
    
    //TODO (in the View): Make sure all of the board images are blank.png
    
    // Was done to start, but doubled checked!
    
    //TODO (in the View, and link here in the Controller): Create a new label for "status text" Ex: Whose turn it is, whether someone won, and whether there was an invalid move
    @IBOutlet weak var resetTimerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
   
    func initializeStatus(){
        statusLabel.text = "\(ticTacToe.getTurn())'s Turn!"
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        //Step 1 - Get the row number and column number from the button text (See hint in assignment instructions)
        //get Row Number
        let indexRow = 2
        
        let charAtRow = (sender.titleLabel?.text?.index((sender.titleLabel?.text!.startIndex)!, offsetBy: indexRow))!
        let row = sender.titleLabel?.text?[charAtRow].wholeNumberValue! ?? -1
        
        //get Col Number
        let indexCol = 0
        let charAt = (sender.titleLabel?.text?.index((sender.titleLabel?.text!.startIndex)!, offsetBy: indexCol))!
        let col = sender.titleLabel?.text?[charAt].wholeNumberValue! ?? -1
        
        //Step 2 - Place the marker in the *model*
        
        if (ticTacToe.placeMarker(row: row, column: col)){
        //If placing was successful....
           //Step 3 - Get the turn from the *model* and place the appropriate image in the spot in the images array
            images![col][row].image = UIImage(named: ticTacToe.getTurn())
           //Step 4 - Check for a winner, updating the status message and creating a countdown timer to reset the game if necessary
        if (ticTacToe.didWin() != " "){
            
            statusLabel.text = "\(ticTacToe.didWin()) Won!"
           var resetTime = 15
            self.resetTimerLabel.text =  "Resetting game in \(resetTime) seconds"
            Timer.scheduledTimer(withTimeInterval:1.0,repeats: true){timer in
             resetTime -= 1
                self.resetTimerLabel.text =  "Resetting game in \(resetTime) seconds"
                if resetTime == 0{
                    self.ticTacToe.reset()
                    self.resetTimerLabel.text = ""
                    self.statusLabel.text = "\(self.ticTacToe.getTurn())'s Turn!"
                    for row in 0...2{
                        for col in 0...2{
                            self.images![row][col].image = UIImage(named: "blank")
                }
            }
                    timer.invalidate()
                }
            }
        }
           // Check the EggTimer assignment on Udemy for hints on creating the countdown timer
        
           //Step 5 - If no one won, make the *model* go to the next turn, get the current turn from the model and update the status message.
            
        else {
            ticTacToe.nextTurn()
        statusLabel.text = "\(ticTacToe.getTurn())'s Turn!"
            }
            
    }
        //If placing the marker wasn't successful, change the status message, so the user knows what's wrong
        else{
            statusLabel.text = "That's an invalid location"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This loads the image array so it matches the model
        images = [[upperLeft, upperMiddle, upperRight],
                  [centerLeft, centerMiddle, centerRight],
                  [bottomLeft, bottomMiddle, bottomRight]]
        initializeStatus()
    }


}

