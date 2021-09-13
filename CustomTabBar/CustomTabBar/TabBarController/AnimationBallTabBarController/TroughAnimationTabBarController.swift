//
//  TroughAnimtionTabBarController.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/12/21.
//

import UIKit

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
        animationItem = UIImageView(frame: CGRect(x: self.view.bounds.width/6-25, y: -20, width: 50, height: 50))
        animationItem.contentMode = .center
        animationItem.layer.cornerRadius = 25
        animationItem.layer.masksToBounds = false
        animationItem.layer.shadowPath = UIBezierPath(roundedRect: animationItem.bounds, cornerRadius: animationItem.layer.cornerRadius).cgPath
        animationItem.layer.shadowColor = UIColor.black.cgColor
        animationItem.layer.shadowOpacity = 0.15
        animationItem.layer.shadowRadius = 2
        animationItem.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        self.tabBar.addSubview(animationItem)
    }
    
    // MARK: - Event Responses
    
    // MARK: - Private Methods
    private func handleTabBarSelected(_ keyPath: String?, _ change: [NSKeyValueChangeKey : Any]?) {
        guard keyPath == "selectedIndex", let selectedIndex = change?[.newKey] as? Int else { return }
        guard self.tabBar is TroughAnimationTabBar else { return }
        let troughTabBar = self.tabBar as! TroughAnimationTabBar
        troughTabBar.nextIndex = selectedIndex
        updateAnimationBar()
        updateItemImage()
        troughTabBar.animationTabBar()
    }
    
    private func handleViewControllersConfiged(_ keyPath: String?, _ change: [NSKeyValueChangeKey : Any]?) {
        guard keyPath == "viewControllers", let viewControllers = change?[.newKey] as? [UIViewController] else { return }
        for (index, vc) in viewControllers.enumerated() {
            vc.tabBarItem.tag = index
        }
    }
    
    private func updateAnimationBar() {
        guard previousIndex != nil else {
            animationItem.image = self.tabBar.items?[self.selectedIndex].image?.withTintColor(highlightTabIconColor)
            animationItem.backgroundColor = tabBarBackgroundColor
            setAnimationItemFrame()
            return
        }
        UIView.animate(withDuration: animationDuration) { [unowned self] in
            setAnimationItemFrame()
        }
    }
    
    private func setAnimationItemFrame() {
        if self.selectedIndex == 0 {
            self.animationItem.frame = CGRect(x: self.view.bounds.width/6-25, y: -20, width: 50, height: 50)
            animationItem.image = self.tabBar.items?[self.selectedIndex].image?.withTintColor(highlightTabIconColor)
        } else if self.selectedIndex == 1 {
            self.animationItem.frame = CGRect(x: (self.view.bounds.width*3/6)-25, y: -20, width: 50, height: 50)
            animationItem.image = self.tabBar.items?[self.selectedIndex].image?.withTintColor(highlightTabIconColor)
        } else if self.selectedIndex == 2 {
            self.animationItem.frame = CGRect(x: (self.view.bounds.width*5/6)-25, y: -20, width: 50, height: 50)
            animationItem.image = self.tabBar.items?[self.selectedIndex].image?.withTintColor(highlightTabIconColor)
        }
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
}

extension TroughAnimationTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        previousIndex = self.selectedIndex
        self.selectedIndex = item.tag
    }
}
