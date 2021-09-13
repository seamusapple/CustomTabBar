//
//  TroughAnimtionTabBarController.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/12/21.
//

import UIKit

enum TabBarAnimationType {
    case horizontal
    case dropRise
}

class TroughAnimationTabBarController: UITabBarController {

    // MARK: - Public Methods
    
    // MARK: - Public Properties
    var animationDuration: TimeInterval = 0.5
    var tabBarBackgroundColor = UIColor(named: "GlossyGrape")! {
        didSet {
            animationItem.backgroundColor = tabBarBackgroundColor
            guard self.tabBar is TroughAnimationTabBar else { return }
            let troughTabBar = self.tabBar as! TroughAnimationTabBar
            troughTabBar.tabBarBackgroundColor = tabBarBackgroundColor
        }
    }
    var highlightTabIconColor = UIColor(named: "DeepSaffron")! {
        didSet {
            animationItem.image = self.tabBar.items?[self.selectedIndex].image?.withTintColor(highlightTabIconColor)
        }
    }
    var highlightAnimationType = TabBarAnimationType.horizontal
    var ballOffset: CGFloat = 20 {
        didSet { updateBall() }
    }
    var ballSize: CGSize = CGSize(width: 50, height: 50) {
        didSet { updateBall() }
    }
    var ballCornerRadius: CGFloat = 25 {
        didSet { updateBall() }
    }
    var troughExtend: CGFloat = 60 {
        didSet {
            guard self.tabBar is TroughAnimationTabBar else { return }
            let troughTabBar = self.tabBar as! TroughAnimationTabBar
            troughTabBar.troughExtend = troughExtend
        }
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubComponents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init Methods
    
    // MARK: - Super Override
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        handleTabBarSelected(keyPath, change)
        handleViewControllersConfiged(keyPath, change)
    }
    
    // MARK: - Private Methods
    private func initSubComponents() {
        setupTabBar()
        setupAnimationBall()
        self.delegate = self
        addObserver(self, forKeyPath: "selectedIndex", options: .new, context: nil)
        addObserver(self, forKeyPath: "viewControllers", options: .new, context: nil)
    }
    
    private func setupTabBar() {
        let customTabBar = TroughAnimationTabBar()
        customTabBar.animationDuration = animationDuration
        customTabBar.tabBarBackgroundColor = tabBarBackgroundColor
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    private func setupAnimationBall() {
        animationItem = UIImageView(frame: CGRect(origin: CGPoint(x: basicWidth-ballSize.height/2, y: -ballOffset), size: ballSize))
        animationItem.contentMode = .center
        animationItem.layer.cornerRadius = ballCornerRadius
        animationItem.layer.masksToBounds = false
        animationItem.layer.shadowPath = UIBezierPath(roundedRect: animationItem.bounds, cornerRadius: animationItem.layer.cornerRadius).cgPath
        animationItem.layer.shadowColor = UIColor.black.cgColor
        animationItem.layer.shadowOpacity = 0.15
        animationItem.layer.shadowRadius = 2
        animationItem.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.tabBar.addSubview(animationItem)
    }
    
    private func updateBall() {
        animationItem.frame = CGRect(origin: CGPoint(x: basicWidth-ballSize.height/2, y: -ballOffset), size: ballSize)
        animationItem.layer.shadowPath = UIBezierPath(roundedRect: animationItem.bounds, cornerRadius: animationItem.layer.cornerRadius).cgPath
        animationItem.layer.cornerRadius = ballCornerRadius
    }
    
    // MARK: - Event Responses
    
    // MARK: - Private Methods
    private func handleTabBarSelected(_ keyPath: String?, _ change: [NSKeyValueChangeKey : Any]?) {
        guard keyPath == "selectedIndex", let selectedIndex = change?[.newKey] as? Int else { return }
        guard self.tabBar is TroughAnimationTabBar else { return }
        let troughTabBar = self.tabBar as! TroughAnimationTabBar
        troughTabBar.nextIndex = selectedIndex
        updateAnimationCircle()
        updateItemImage()
        troughTabBar.animationTabBar()
    }
    
    private func handleViewControllersConfiged(_ keyPath: String?, _ change: [NSKeyValueChangeKey : Any]?) {
        guard keyPath == "viewControllers", let viewControllers = change?[.newKey] as? [UIViewController] else { return }
        for (index, vc) in viewControllers.enumerated() {
            vc.tabBarItem.tag = index
        }
    }
    
    private func updateAnimationCircle() {
        guard previousIndex != nil else {
            animationItem.image = self.tabBar.items?[self.selectedIndex].image?.withTintColor(highlightTabIconColor)
            animationItem.backgroundColor = tabBarBackgroundColor
            setAnimationItemFrame()
            return
        }
        switch highlightAnimationType {
        case .horizontal:
            horizontalAnimationCircle()
        case .dropRise:
            dropRiseAnimationCircle()
        }
    }
    
    private func horizontalAnimationCircle() {
        UIView.animate(withDuration: animationDuration) { [unowned self] in
            setAnimationItemFrame()
        }
    }
    
    private func setAnimationItemFrame() {
        guard let itemCount = self.tabBar.items?.count, self.selectedIndex < itemCount else { return }
        self.animationItem.frame.origin.x = CGFloat(self.selectedIndex*2)*basicWidth+basicWidth-ballSize.width/2
        animationItem.image = self.tabBar.items?[self.selectedIndex].image?.withTintColor(highlightTabIconColor)
    }
    
    fileprivate func createAnimationCirclePath() -> UIBezierPath {
        let path = UIBezierPath()
        let targetPointOneX = self.animationItem.frame.midX + CGFloat(self.selectedIndex-self.previousIndex!)*basicWidth
        let controlPointOneX = self.animationItem.frame.midX
        let targetPointTwoX = self.animationItem.frame.midX + CGFloat(self.selectedIndex-self.previousIndex!)*CGFloat(2)*basicWidth
        let controlPointTwoX = self.animationItem.frame.midX + CGFloat(self.selectedIndex-self.previousIndex!)*CGFloat(2)*basicWidth
        path.move(to: CGPoint(x: self.animationItem.frame.midX, y: 5))
        path.addQuadCurve(to: CGPoint(x: targetPointOneX, y: self.tabBar.frame.height),
                          controlPoint: CGPoint(x: controlPointOneX, y: self.tabBar.frame.height))
        path.addQuadCurve(to: CGPoint(x: targetPointTwoX, y: 5),
                          controlPoint: CGPoint(x: controlPointTwoX, y: self.tabBar.frame.height))
        return path
    }
    
    private func dropRiseAnimationCircle() {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = createAnimationCirclePath().cgPath
        animation.duration = animationDuration
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationItem.layer.add(animation, forKey: "dropRiseAnimation")
        setAnimationItemFrame()
    }
    
    private func updateItemImage() {
        guard let tabBarButtonClass = NSClassFromString("UITabBarButton") else { return }
        let allTabBarButtons = tabBar.subviews.filter { $0.isKind(of: tabBarButtonClass) }
        let allTabBarImage = allTabBarButtons.flatMap { $0.subviews }.compactMap { $0 as? UIImageView }
        let targetImage = allTabBarImage.filter { $0.image == tabBar.items?[self.selectedIndex].image }.first
        let otherShownImage = allTabBarImage.filter { $0.image != tabBar.items?[self.selectedIndex].image }
        guard let imageView = targetImage else { return }
        addHideAnimation(imageView)
        addShowAnimation(otherShownImage)
    }
    
    fileprivate func addHideAnimation(_ imageView: UIImageView) {
        guard previousIndex != nil else { imageView.layer.opacity = 0; return }
        let transparentAnimation = CABasicAnimation(keyPath: "opacity")
        transparentAnimation.fromValue = 1
        transparentAnimation.toValue = 0
        transparentAnimation.duration = animationDuration
        transparentAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transparentAnimation.fillMode = .forwards
        transparentAnimation.isRemovedOnCompletion = true
        imageView.layer.add(transparentAnimation, forKey: "iconTransparent")
        imageView.layer.opacity = 0
    }
    
    fileprivate func addShowAnimation(_ otherShownImage: [UIImageView]) {
        for imageView in otherShownImage where imageView.alpha == 0 {
            guard previousIndex != nil else { imageView.layer.opacity = 1; return }
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 0
            opacityAnimation.toValue = 1
            opacityAnimation.duration = animationDuration
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            opacityAnimation.fillMode = .forwards
            opacityAnimation.isRemovedOnCompletion = true
            imageView.layer.add(opacityAnimation, forKey: "iconOpacity")
            imageView.layer.opacity = 1
        }
    }
    
    // MARK: - Private Properties
    private var animationItem = UIImageView()
    private var previousIndex: Int?
    private var basicWidth: CGFloat {
        guard let tabCount = self.tabBar.items?.count else { return 1 }
        return self.tabBar.frame.width/CGFloat(2*tabCount)
    }
}

extension TroughAnimationTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        previousIndex = self.selectedIndex
        self.selectedIndex = item.tag
    }
}
