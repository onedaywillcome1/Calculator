//
//  ViewController.swift
//  Calculator
//
//  Created by Ahmet Atalay on 10/06/16.
//  Copyright © 2016 Ahmet Atalay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userInMiddleText = false
    var firstDigitisZero = false
    var appendingDigitisZero = false
    
    @IBAction func touchDigit(sender: UIButton) {
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
    
    @IBAction func performOperation(sender: UIButton) {
        userInMiddleText = false
        let mathematicalSymbol = sender.currentTitle!
        if mathematicalSymbol == "π" {
            display.text = String(M_PI)
        }
    }
}

