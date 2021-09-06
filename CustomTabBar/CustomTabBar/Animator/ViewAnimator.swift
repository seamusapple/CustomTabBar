//
//  ViewAnimator.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/5/21.
//

import UIKit

typealias ViewAnimationBlock = (_ fillColorView: UIView, _ animatedView: UIView) -> Void

final class ViewAnimator {
    private let animation: ViewAnimationBlock
    
    init(animation: @escaping ViewAnimationBlock) {
        self.animation = animation
    }
    
    func animated(fillColorView: UIView, animatedView: UIView) {
        animation(fillColorView, animatedView)
    }
}

enum ViewAnimation {
    case fillUpwards(duration: TimeInterval, delay: TimeInterval)
    case fillDownwards(duration: TimeInterval, delay: TimeInterval)
    case fillLeftwards(duration: TimeInterval, delay: TimeInterval)
    case fillRightwards(duration: TimeInterval, delay: TimeInterval)
    case fillCenterwards(duration: TimeInterval, delay: TimeInterval)
    
    func getAnimation() -> ViewAnimationBlock {
        switch self {
        case .fillUpwards(let duration, let delay):
            return ViewAnimationFactory.makeFillUpwardsAnimation(duration: duration, delayFactor: delay)
        case .fillDownwards(let duration, let delay):
            return ViewAnimationFactory.makeFillDownwardsAnimation(duration: duration, delayFactor: delay)
        case .fillLeftwards(let duration, let delay):
            return ViewAnimationFactory.makeFillLeftwardsAnimation(duration: duration, delayFactor: delay)
        case .fillRightwards(let duration, let delay):
            return ViewAnimationFactory.makeFillRightwardsAnimation(duration: duration, delayFactor: delay)
        case .fillCenterwards(let duration, let delay):
            return ViewAnimationFactory.makeFillCenterwardsAnimation(duration: duration, delayFactor: delay)
        }
    }
}

enum ViewAnimationFactory {
    static func makeFillUpwardsAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> ViewAnimationBlock {
        return { fillColorView, animatedView in
            fillColorView.frame.origin = CGPoint.zero
            fillColorView.frame.origin.y = fillColorView.frame.height
            UIView.animate(
                withDuration: duration,
                delay: delayFactor) {
                fillColorView.frame.origin.y = 0
            }
        }
    }
    
    static func makeFillDownwardsAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> ViewAnimationBlock {
        return { fillColorView, animatedView in
            fillColorView.frame.origin = CGPoint.zero
            fillColorView.frame.origin.y = -fillColorView.frame.height
            UIView.animate(
                withDuration: duration,
                delay: delayFactor) {
                fillColorView.frame.origin.y = 0
            }
        }
    }
    
    static func makeFillLeftwardsAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> ViewAnimationBlock {
        return { fillColorView, animatedView in
            fillColorView.frame.origin = CGPoint.zero
            fillColorView.frame.origin.x = fillColorView.frame.width
            UIView.animate(
                withDuration: duration,
                delay: delayFactor) {
                fillColorView.frame.origin.x = 0
            }
        }
    }
    
    static func makeFillRightwardsAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> ViewAnimationBlock {
        return { fillColorView, animatedView in
            fillColorView.frame.origin = CGPoint.zero
            fillColorView.frame.origin.x = -fillColorView.frame.width
            UIView.animate(
                withDuration: duration,
                delay: delayFactor) {
                fillColorView.frame.origin.x = 0
            }
        }
    }
    
    static func makeFillCenterwardsAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> ViewAnimationBlock {
        return { fillColorView, animatedView in
            animatedView.needReAlignFillAnimationView = true
            fillColorView.frame = CGRect.zero
            fillColorView.center = CGPoint(x: animatedView.bounds.midX, y: animatedView.bounds.midY)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor) {
                fillColorView.frame = animatedView.bounds
                fillColorView.center = CGPoint(x: animatedView.bounds.midX, y: animatedView.bounds.midY)
            }
        }
    }
}
