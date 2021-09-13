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
    var animationDuration: TimeInterval = 0.5
    var tabBarBackgroundColor = UIColor(named: "GlossyGrape")!
    var troughExtend: CGFloat = 60

    // MARK: - Public Methods
    func animationTabBar() {
        guard self.currentSelectedIndex != self.nextIndex else { return }
        self.currentSelectedIndex = self.nextIndex
        updateShape()
    }
    
    // Super Override
    override func draw(_ rect: CGRect) {
        self.addShape()
        self.backgroundColor = tabBarBackgroundColor
        self.unselectedItemTintColor = .black
        self.tintColor = .black
    }
    
    // MARK: - Private Methods
    private func updateShape() {
        let newPath = createPath()
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = animationDuration
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
        shapeLayer?.fillColor = tabBarBackgroundColor.cgColor
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
        guard let itemCount = self.items?.count, self.nextIndex < itemCount else { return }
        let startPointX: CGFloat = CGFloat((self.nextIndex*2))*basicWidth+basicWidth-troughExtend
        let curveOneTargetPointX: CGFloat = CGFloat((self.nextIndex*2))*basicWidth+basicWidth
        let curveOneControlOnePointX: CGFloat = CGFloat((self.nextIndex*2))*basicWidth+basicWidth-troughExtend/3
        let curveOneControlTwoPointX: CGFloat = CGFloat((self.nextIndex*2))*basicWidth+basicWidth-troughExtend*2/3
        let curveTwoTargetPointX: CGFloat = CGFloat((self.nextIndex*2))*basicWidth+basicWidth+troughExtend
        let curveTwoControlOnePointX: CGFloat = CGFloat((self.nextIndex*2))*basicWidth+basicWidth+troughExtend*2/3
        let curveTwoControlTwoPointX: CGFloat = CGFloat((self.nextIndex*2))*basicWidth+basicWidth+troughExtend/3
        let curveControlOnePointY: CGFloat = self.frame.height/2/8
        let curveControlTwoPointY: CGFloat = self.frame.height/2*8.5/10
        path.addLine(to: CGPoint(x: startPointX, y: 0))
        path.addCurve(to: CGPoint(x: curveOneTargetPointX, y: self.frame.height/2),
                      controlPoint1: CGPoint(x: curveOneControlOnePointX, y: curveControlOnePointY),
                      controlPoint2: CGPoint(x: curveOneControlTwoPointX, y: curveControlTwoPointY))
        path.addCurve(to: CGPoint(x: curveTwoTargetPointX, y: 0),
                      controlPoint1: CGPoint(x: curveTwoControlOnePointX, y: curveControlTwoPointY),
                      controlPoint2: CGPoint(x: curveTwoControlTwoPointX, y: curveControlOnePointY))
    }
    
    // MARK: - Private Properties
    private var shapeLayer: CAShapeLayer?
    private var basicWidth: CGFloat {
        guard let tabCount = self.items?.count else { return 1 }
        return self.frame.width/CGFloat(2*tabCount)
    }
}
