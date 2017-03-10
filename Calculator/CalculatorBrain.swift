//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jianqun Chen on 2/28/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//


import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


class Solution {
    private var maxDepth = 0
    private var res = 0
    
    func solve(_ root: TreeNode?, _ depth: Int) {
        if root != nil {
            if maxDepth < depth {
                maxDepth = depth
                res = root!.val
            }
            solve(root!.left, depth + 1)
            solve(root!.right, depth + 1)
        }
    }
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        solve(root, 0)
        return res
    }
}

class CalculatorBrain
{
    private var accumulator = 0.0
    private var rightValue = ""
    var rightValueIsDone = false
    var leftValue = ""
    var finishEqual = false
    var history = ""
    var variableValues: Dictionary<String, Double> = [:]
    
    typealias PropertyList = [AnyObject]
    var internalProgam = PropertyList()
    
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgam.append(operand as AnyObject)
    }
    
    func setVariable(symbol: String, value: Double) {
        variableValues[symbol] = value
    }
    
    var program: PropertyList {
        get {
            return internalProgam
        }
        set {
            clearOp()
            for op in newValue {
                if let operand = op as? Double {
                    setOperand(operand: operand)
                }
                if let operation = op as? String {
                    performOperation(symbol: operation)
                }
            }
        }
    }
    
    private func getVariable(symbol: String) -> Double {
        return variableValues[symbol] ?? 0.0
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "sin": Operation.UnaryOperation(sin),
        "×": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "−": Operation.BinaryOperation({$0 - $1}),
        "x^2": Operation.UnaryOperation({$0 * $0}),
        "x^3": Operation.UnaryOperation({$0 * $0 * $0}),
        "x^y": Operation.BinaryOperation({pow($0, $1)}),
        "∛": Operation.UnaryOperation({pow($0, 1.0/3)}),
        "=": Operation.Equals,
        "M": Operation.Variable
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Variable
    }
    
    func performOperation(symbol: String) {
        internalProgam.append(symbol as AnyObject)
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
                rightValue = symbol
                rightValueIsDone = true
            case .UnaryOperation(let function):
                if pending != nil {
                    if rightValue == "" {
                        rightValue = String(accumulator)
                    }
                    rightValue = symbol + rightValue
                } else {
                    leftValue = symbol + "(" + leftValue + ")"
                }
                rightValueIsDone = true
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                finishEqual = false
                if rightValue == "" {
                    if rightValueIsDone {
                        rightValue = symbol
                    } else {
                        rightValue = String(accumulator) + symbol
                    }
                }
                rightValueIsDone = false
                leftValue += rightValue
                rightValue = ""
                excutePending()
                pending = pendingBinaryOperationInfo(binaryFunction:function, firstOperand: accumulator)
            case .Equals:
                finishEqual = true
                if rightValue == "" && pending != nil {
                    rightValue = String(accumulator)
                }
                leftValue += rightValue
                rightValueIsDone = true
                rightValue = ""
                excutePending()
            case .Variable:
                accumulator = variableValues[symbol] ?? 0.0
                rightValue = symbol
                rightValueIsDone = true
            }
            history = leftValue + rightValue
        }
    }
    
    private func excutePending() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    struct pendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var pending: pendingBinaryOperationInfo?
    
    func clearMemory() {
        variableValues = [:]
    }
    
    func clearState() {
        clearOp()
        clearMemory()
    }
    
    func clearOp() {
        pending = nil
        accumulator = 0.0
        history = ""
        leftValue = ""
        rightValue = ""
        rightValueIsDone = false
        internalProgam = []
        finishEqual = false
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    var isPartial: Bool {
        get {
            return pending != nil
        }
    }
}
