//
//  ViewController.swift
//  retro-calculator
//
//  Created by Vinodh Srinivasan on 5/4/16.
//  Copyright © 2016 creaTech. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel : UILabel!


    enum Operation {
        case MULTIPLY
        case DIVIDE
        case SUBTRACT
        case ADD
        case EMPTY
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftNumStr = ""
    var rightNumStr = ""
    var resultStr = ""
    
    var currentOperation: Operation = Operation.EMPTY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func handleNumbersPressed(button: UIButton) {
        playBtnSound()
        runningNumber += "\(button.tag)"
        resultLabel.text = runningNumber
    }

    @IBAction func handleDividePress(sender: UIButton) {
        processOperation(Operation.DIVIDE)
    }
    
    @IBAction func handleMultiplyPress(sender: UIButton){
        processOperation(Operation.MULTIPLY)
    }
    
    @IBAction func handleAddPress(sender : UIButton){
        processOperation(Operation.ADD)
    }
    
    @IBAction func handleSubtractPress(sender: UIButton) {
        processOperation(Operation.SUBTRACT)
    }
    
    @IBAction func handleEqualsPress(sender:  UIButton){
        processOperation(currentOperation)
    }
    
    func processOperation(pressedOp: Operation) {
        playBtnSound()
        
        if(runningNumber != "") {
            if(currentOperation != Operation.EMPTY) {
                
                rightNumStr = runningNumber
                
                if(currentOperation == Operation.MULTIPLY) {
                    resultStr = "\(Double(leftNumStr)! * Double(rightNumStr)!)"
                }else if(currentOperation == Operation.DIVIDE) {
                    resultStr = "\(Double(leftNumStr)! / Double(rightNumStr)!)"
                }else if(currentOperation == Operation.ADD) {
                    resultStr = "\(Double(leftNumStr)! + Double(rightNumStr)!)"
                }else if(currentOperation == Operation.SUBTRACT) {
                    resultStr = "\(Double(leftNumStr)! - Double(rightNumStr)!)"
                }
                
                resultLabel.text = resultStr
                leftNumStr = resultStr
                rightNumStr = ""
                
            }else {
                //User presses the operator first time
                leftNumStr = runningNumber
            }
        }
        runningNumber = ""
        currentOperation = pressedOp
        
    }
    
    func playBtnSound() {
        if(btnSound.playing) {
            btnSound.stop()
        }
        btnSound.play()
    }

}

