//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Ahmet Atalay on 12/06/16.
//  Copyright © 2016 Ahmet Atalay. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private var accumulator = 0.0
    private var totalString = ""
    
    func logOperands(symbol:String) -> String{
        totalString = totalString + symbol
        return totalString
    }
    
    func setOperand(operand: Double)  {
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "AC" : Operation.Clear,
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Clear
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String)  {
        if let operation = operations[symbol]{
            switch operation {
            case .Clear: clear()
            case .Constant(let value): accumulator = value
            case .UnaryOperation (let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executeBinaryOperation()
                pending = pendingBinaryOperation(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executeBinaryOperation()
            }
        }
    }
    
    private func clear(){
        pending = nil
        accumulator = 0.0
    }
    private func executeBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: pendingBinaryOperation?
    
    private struct pendingBinaryOperation {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand : Double
    }
    
    var result: Double {
        get{
            return accumulator
        }
    }
}

