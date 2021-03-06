//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/11/21.
//

import UIKit

@IBDesignable
class CustomTabBar: UITabBar {
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
        self.unselectedItemTintColor = .white
        self.tintColor = UIColor(named: "DeepSaffron")
    }
    
    fileprivate func addAnotherTrickyQuadCurve(_ path: UIBezierPath, _ centerWidth: CGFloat, _ height: CGFloat) {
        path.move(to: CGPoint(x: 0, y: -20)) // Start Point
        path.addLine(to: CGPoint(x: centerWidth-50, y: 0)) // Left slope
        path.addQuadCurve(to: CGPoint(x: centerWidth-30, y:20), controlPoint: CGPoint(x: centerWidth-30, y: 5)) // Top left curve
        path.addLine(to: CGPoint(x: centerWidth-29, y: height-10)) // Left vertical line
        path.addQuadCurve(to: CGPoint(x: centerWidth, y:height+10), controlPoint: CGPoint(x: centerWidth-30, y: height+10)) // Bottom left curve
        path.addQuadCurve(to: CGPoint(x: centerWidth+40, y:height-10), controlPoint: CGPoint(x: centerWidth+40, y: height+10)) // Bottom right curve
        path.addLine(to: CGPoint(x: centerWidth+41, y: 20)) // Right vertical line
        path.addQuadCurve(to: CGPoint(x: centerWidth+50, y:0), controlPoint: CGPoint(x: centerWidth+41, y: 5)) // Top right curve
        path.addLine(to: CGPoint(x: self.frame.width, y: -20)) // Right slope
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
    }
    
    private func createPath() -> CGPath {
        let height: CGFloat = 15
        let path = UIBezierPath()
        let centerWidth = self.frame.width/2
        
        addQuadCurvePathOne(path, centerWidth, height)
//        addAnotherTrickyQuadCurve(path, centerWidth, height)
        
        return path.cgPath
    }
    
    fileprivate func addQuadCurvePathOne(_ path: UIBezierPath, _ centerWidth: CGFloat, _ height: CGFloat) {
        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: self.frame.width, y: 0), controlPoint: CGPoint(x: centerWidth, y: height))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
    }
}
