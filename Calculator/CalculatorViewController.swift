//
//  ViewController.swift
//  Calculator
//
//  Created by Jianqun Chen on 2/28/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private var graphFunctions: Dictionary<String, (Double) -> Double> = [
        "√": sqrt,
        "cos": cos,
        "sin": sin,
        "x^2": {$0 * $0},
        "x^3": {$0 * $0 * $0},
        "∛": {pow($0, 1.0/3)},
    ]
    
    private func getGraphFunctions() -> String? {
        for i in 0..<(brain.program.count - 1) {
            if (brain.program[i] as? String) == nil || (brain.program[i + 1] as? String) == nil {
                continue
            }
            if (brain.program[i] as! String) == "M" && graphFunctions[brain.program[i + 1] as! String] != nil {
                return brain.program[i + 1] as? String
            }
        }
        return nil
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let f = getGraphFunctions()
        if f != nil && segue.identifier == "Show Graph" {
            let title = f! + "(M)"
            if let dvc = segue.destination as? UINavigationController {
                let vc = dvc.visibleViewController as? GraphViewController
                vc?.title = title
                vc?.model.function = graphFunctions[f!]!
            }
            if let dvc = segue.destination as? GraphViewController {
                dvc.title = title
                dvc.model.function = graphFunctions[f!]!
            }
        }
    }
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    
    var isTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    func showHistory() {
        if brain.isPartial {
            history.text = brain.history + "..."
        } else {
            history.text = brain.history + "="
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        brain.program = savedProgram!
        displayValue = brain.result
    }
    
    
    @IBAction func touchClear(_ sender: UIButton) {
        brain.clearState()
        isTyping = false
        display.text = "0"
        history.text = "0"
    }
    
    @IBAction func touchDot(_ sender: UIButton) {
        let number = display.text!
        if isTyping {
            if !number.characters.contains(".") {
                display.text = display.text! + "."
            }
        } else {
            display.text = "0."
            isTyping = true
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if brain.finishEqual {
            brain.leftValue = ""
            brain.rightValueIsDone = false
        }
        let digit = sender.currentTitle!
        if isTyping {
            display.text = display.text! + digit
        } else {
            isTyping = true
            display.text = digit
        }
    }
    
    @IBAction func setM() {
        savedProgram = brain.program
        brain.variableValues["M"] = displayValue
        brain.program = savedProgram!
        displayValue = brain.result
    }
    
    func backspace() {
        let text = display.text!
        display.text = text.substring(to: text.index(before: text.endIndex))
    }
    @IBAction func undo() {
        if isTyping {
            backspace()
        } else {
            savedProgram = brain.program
            if (savedProgram?.count)! > 0 {
                _ = savedProgram!.popLast()
            }
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if isTyping {
            brain.setOperand(operand:displayValue)
            isTyping = false
        }
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol:symbol)
        }
        displayValue = brain.result
        showHistory()
    }
    
    fileprivate var brain: CalculatorBrain = CalculatorBrain()
}

