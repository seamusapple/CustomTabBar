//
//  TroghAnimationTabBar.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/12/21.
//

import UIKit

@IBDesignable
class TroghAnimationTabBar: UITabBar {
    private var shapeLayer: CALayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor(named: "GlossyGrape")?.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor(named: "GlossyGrape")?.cgColor
        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.unselectedItemTintColor = .black
        self.tintColor = UIColor(named: "DeepSaffron")
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath()
        addQuadCurvePathOne(path)
        
        return path.cgPath
    }
    
    fileprivate func addQuadCurvePathOne(_ path: UIBezierPath) {
        let centerWidth = self.frame.width/2
        let centerHeight = self.frame.height/2
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerWidth-60, y: 0))
        path.addCurve(to: CGPoint(x: centerWidth, y: centerHeight), controlPoint1: CGPoint(x: centerWidth-20, y: 0), controlPoint2: CGPoint(x: centerWidth-35, y: centerHeight))
        path.addCurve(to: CGPoint(x: centerWidth+60, y: 0), controlPoint1: CGPoint(x: centerWidth+35, y: centerHeight), controlPoint2: CGPoint(x: centerWidth+20, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
    }
}
