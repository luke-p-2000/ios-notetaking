//
//  Canvas.swift
//  test1
//
//  Created by Jonathan Nguyen on 16/5/2022.
//

import Foundation
import UIKit

class Canvas: UIView{
    
    func undo(){
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }

    
    var lines = [[CGPoint]]()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach{ (line) in
            for (i, p) in line.enumerated(){
                if i==0{
                    context.move(to: p)
                }
                else{
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        //print point
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
}


class Line {

    var start: CGPoint
    var end: CGPoint

    init(start _start: CGPoint, end _end: CGPoint ) {
        start = _start
        end = _end

    }

}

    
