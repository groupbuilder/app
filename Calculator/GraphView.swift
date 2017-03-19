//
//  graphView.swift
//  Calculator
//
//  Created by Jianqun Chen on 3/10/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    @IBInspectable
    var scale: Double = 30.0 {
        didSet {
            print("set scale = \(scale)")
            setNeedsDisplay()
        }
    }
    var origin = CGPoint(x: 200, y: 200) {
        didSet {
            setNeedsDisplay()
        }
    }
    var function: (Double) -> Double = {$0 * $0} {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private func drawLine(from a: CGPoint, to b: CGPoint) {
        let line = UIBezierPath()
        line.move(to: a)
        line.addLine(to: b)
        line.close()
        line.stroke()
    }
    
    private func drawFunction(fromX minX: CGFloat, toX maxX: CGFloat) {
        let line = UIBezierPath()
        var firstPoint: CGPoint? = nil
        var x = Double(minX)
        while x < Double(maxX) {
            let y = origin.y - CGFloat(function((x - Double(origin.x)) / scale) * scale)
            if y.isNormal && y >= bounds.minY && y <= bounds.maxY {
                if firstPoint == nil {
                    firstPoint = CGPoint(x: CGFloat(x), y: y)
                    line.move(to: firstPoint!)
                } else {
                    line.addLine(to: CGPoint(x: CGFloat(x), y: y))
                }
            }
            x += 1.0
        }
        if firstPoint != nil {
            line.move(to: firstPoint!)
        }
        line.close()
        line.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        drawLine(from: CGPoint(x: bounds.minX, y: origin.y), to: CGPoint(x: bounds.maxX, y: origin.y))
        drawLine(from: CGPoint(x: origin.x, y: bounds.minY), to: CGPoint(x: origin.x, y: bounds.maxY))
        UIColor.red.set()
        drawFunction(fromX: bounds.minX, toX: bounds.maxX)
    }
    
}
