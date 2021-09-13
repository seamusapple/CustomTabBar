//
//  TroghAnimationTabBar.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/12/21.
//

import UIKit

@IBDesignable
class TroughAnimationTabBar: UITabBar {
    // MARK: - Public Properties
    var currentSelectedIndex: Int = 0
    var nextIndex: Int = 0
    
    // MARK: - Private Methods
    func animationTabBar(isAnimated: Bool) {
        guard self.currentSelectedIndex != self.nextIndex else { return }
        self.currentSelectedIndex = self.nextIndex
        updateShape(isAnimated: isAnimated)
    }
    
    // Super Override
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = .black
        self.tintColor = .black
    }
    
    // MARK: - Private Methods
    private func updateShape(isAnimated: Bool) {
        let newPath = createPath()
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1.0
        animation.fromValue = shapeLayer?.path
        animation.toValue = newPath
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer?.add(animation, forKey: "path")
        shapeLayer?.path = newPath
    }
    
    private func addShape() {
        shapeLayer = CAShapeLayer()
        shapeLayer?.path = createPath()
        shapeLayer?.strokeColor = UIColor.clear.cgColor
        shapeLayer?.fillColor = UIColor(named: "GlossyGrape")?.cgColor
        shapeLayer?.lineWidth = 1.0
        
        guard shapeLayer != nil && shapeLayer!.superlayer == nil else { return }
        self.layer.insertSublayer(shapeLayer!, at: 0)
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        drawCurve(path)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
    private func drawCurve(_ path: UIBezierPath) {
        let centerWidth = self.frame.width/2
        let centerHeight = self.frame.height/2
        if self.nextIndex == 0 {
            path.addLine(to: CGPoint(x: self.frame.width*1/6-60, y: 0))
            path.addCurve(to: CGPoint(x: self.frame.width*1/6, y: centerHeight), controlPoint1: CGPoint(x: self.frame.width*1/6-20, y: centerHeight/8), controlPoint2: CGPoint(x: self.frame.width*1/6-40, y: centerHeight*8.5/10))
            path.addCurve(to: CGPoint(x: self.frame.width*1/6+60, y: 0), controlPoint1: CGPoint(x: self.frame.width*1/6+40, y: centerHeight*8.5/10), controlPoint2: CGPoint(x: self.frame.width*1/6+20, y: centerHeight/8))
        } else if nextIndex == 1 {
            path.addLine(to: CGPoint(x: centerWidth-60, y: 0))
            path.addCurve(to: CGPoint(x: centerWidth, y: centerHeight), controlPoint1: CGPoint(x: centerWidth-20, y: centerHeight/8), controlPoint2: CGPoint(x: centerWidth-40, y: centerHeight*8.5/10))
            path.addCurve(to: CGPoint(x: centerWidth+60, y: 0), controlPoint1: CGPoint(x: centerWidth+40, y: centerHeight*8.5/10), controlPoint2: CGPoint(x: centerWidth+20, y: centerHeight/8))
        } else if nextIndex == 2 {
            path.addLine(to: CGPoint(x: self.frame.width*5/6-60, y: 0))
            path.addCurve(to: CGPoint(x: self.frame.width*5/6, y: centerHeight), controlPoint1: CGPoint(x: self.frame.width*5/6-20, y: centerHeight/8), controlPoint2: CGPoint(x: self.frame.width*5/6-40, y: centerHeight*8.5/10))
            path.addCurve(to: CGPoint(x: self.frame.width*5/6+60, y: 0), controlPoint1: CGPoint(x: self.frame.width*5/6+40, y: centerHeight*8.5/10), controlPoint2: CGPoint(x: self.frame.width*5/6+20, y: centerHeight/8))
        }
    }
    
    // MARK: - Private Properties
    private var shapeLayer: CAShapeLayer?
}
