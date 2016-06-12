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
    
    func setOperand(operand: Double)  {
        accumulator = operand
        print("accumulator: \(accumulator)")
    }
    
    private var operations: Dictionary<String,Operation> = [
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
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String)  {
        if let operation = operations[symbol]{
            print("Operation: \(operation)")
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation (let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                print("function: \(function)")
                executeBinaryOperation()
                pending = pendingBinaryOperation(binaryFunction: function, firstOperand: accumulator)
                print("Pending : \(pending)")
            case .Equals:
                executeBinaryOperation()
            }
        }
    }
    
    private func executeBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            print("first operand: \(pending!.firstOperand)")
            print("accumulator2: \(accumulator)")
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

