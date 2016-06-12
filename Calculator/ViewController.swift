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
    @IBOutlet weak var historydisplay: UILabel!
    
    var userInMiddleText = false
    
    private var brain = CalculatorBrain()
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        historydisplay.text = brain.logOperands(digit)
        
        if userInMiddleText  {
            let currentText = display.text
            if digit == "." {
                if display.text?.rangeOfString(".") == nil {
                    display.text = currentText!+digit
                }
            }
            else{
                display.text = currentText!+digit
            }

        }else{
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
    
    
    
    @IBAction private func performOperation(sender: UIButton) {
        if userInMiddleText {
            brain.setOperand(displayValue)
            userInMiddleText = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            historydisplay.text = brain.logOperands(mathematicalSymbol)
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

