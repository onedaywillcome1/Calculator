//
//  ViewController.swift
//  Calculator
//
//  Created by Ahmet Atalay on 10/06/16.
//  Copyright © 2016 Ahmet Atalay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    var userInMiddleText = false
    var firstDigitisZero = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInMiddleText {
            if digit == "0" && firstDigitisZero { display.text = digit }
            else if digit != "0" && firstDigitisZero{
                display.text = digit
                firstDigitisZero = false
            }
            else{
                let currentText = display.text
                display.text = currentText!+digit
            }
        }else{
            if digit == "0" { firstDigitisZero = true }
            display.text = digit
        }
        userInMiddleText = true
    }
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(sender: UIButton) {
        if userInMiddleText {
            print("DisplayValue: \(displayValue)")
            brain.setOperand(displayValue)
            userInMiddleText = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

