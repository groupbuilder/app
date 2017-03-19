//
//  GraphViewController.swift
//  Calculator
//
//  Created by Jianqun Chen on 3/10/17.
//  Copyright © 2017 Jianqun Chen. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    struct Model {
        var scale = 30.0
        var function: ((Double) -> Double) = {$0 * $0}
        var origin = CGPoint(x: 200.0, y: 200.0)
    }
    
    var model = Model()
    
    @IBOutlet weak var graph: GraphView!
    
    @IBAction func pinchGraph(_ recognizer: UIPinchGestureRecognizer) {
        print("pinch here")
        switch recognizer.state {
        case .changed, .ended:
            graph.scale *= Double(recognizer.scale)
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    @IBAction func panGraph(_ recognizer: UIPanGestureRecognizer) {
        let oldOrigin = graph.origin
        switch recognizer.state {
        case .changed, .ended:
            let from = recognizer.translation(in: graph)
            graph.origin = CGPoint(x: oldOrigin.x + from.x, y: oldOrigin.y + from.y)
        case .cancelled:
            graph.origin = oldOrigin
        default:
            break
        }
    }
    
    @IBAction func tapOrigin(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            graph.origin = recognizer.location(in: graph)
        }
    }
    
    override func viewDidLoad() {
        updateUI()
    }
    
    func updateUI() {
        graph.scale = model.scale
        graph.origin = model.origin
        graph.function = model.function
    }
}
