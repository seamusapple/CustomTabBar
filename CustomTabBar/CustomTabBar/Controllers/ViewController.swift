//
//  ViewController.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init Methods
    
    // MARK: - Super Override
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = UIColor(named: "CaribbeanGreen")?.withAlphaComponent(0.5)
        fillAnimatedImageOne.frame.origin = CGPoint(x: (view.bounds.width-206)/2, y: (view.bounds.height-206)/2)
        fillAnimatedImageOne.frame.size = CGSize(width: 206, height: 206)
        createFillView(animationView: fillAnimatedImageOne, color: UIColor(named: "YelloCrayola"), imageName: "512_padlock")
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(refreshAnimation), userInfo: nil, repeats: true)
    }
    
    private func createFillView(animationView: FillAnimationView, color: UIColor?, imageName: String) {
        animationView.fillColor = color
        animationView.image = UIImage(named: imageName)
        view.addSubview(animationView)
    }
    
    private func randomAnimation() -> ViewAnimator {
        return animationSet[count%animationSet.count]
    }
    
    private func randomFillColor() -> UIColor? {
        return colorSet[count%6]
    }
    
    // MARK: - Event Responses
    @objc private func refreshAnimation() {
        self.fillAnimatedImageOne.fillColor = randomFillColor()
        let randomAnimator = randomAnimation()
        randomAnimator.animated(fillColorView: self.fillAnimatedImageOne.animationView, animatedView: self.fillAnimatedImageOne)
        count += 1
    }
    
    // MARK: - Private Methods
    
    // MARK: - Private Properties
    private let fillAnimatedImageOne = FillAnimationView()
    private var count = 0
    private let colorSet = [UIColor(named: "BlueJeans"), UIColor(named: "CaribbeanGreen"), UIColor(named: "DeepSaffron"), UIColor(named: "GlossyGrape"), UIColor(named: "Rose"), UIColor(named: "YelloCrayola")]
    private let animationSet = [
        ViewAnimator(animation: ViewAnimation.fillDownwards(duration: 1, delay: 0).getAnimation()),
        ViewAnimator(animation: ViewAnimation.fillUpwards(duration: 1, delay: 0).getAnimation()),
        ViewAnimator(animation: ViewAnimation.fillLeftwards(duration: 1, delay: 0).getAnimation()),
        ViewAnimator(animation: ViewAnimation.fillRightwards(duration: 1, delay: 0).getAnimation()),
        ViewAnimator(animation: ViewAnimation.fillCenterwards(duration: 1, delay: 0).getAnimation())
    ]
}

