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
        guard keyPath == "selectedIndex", let selectedIndex = change?[.newKey] as? Int else { return }
        guard self.tabBar is TroughAnimationTabBar else { return }
        let troughTabBar = self.tabBar as! TroughAnimationTabBar
        troughTabBar.nextIndex = selectedIndex
        updateAnimationBarFrame()
        updateItemImage()
        troughTabBar.animationTabBar(isAnimated: true)
    }
    
    // MARK: - Private Methods
    private func initSubComponents() {
        setupTabBar()
        setupControllers()
        setupAnimationBall()
        self.delegate = self
        addObserver(self, forKeyPath: "selectedIndex", options: .new, context: nil)
    }
    
    private func setupTabBar() {
        let customTabBar = TroughAnimationTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    private func setupControllers() {
        let firstController = DemoViewController()
        let firstTabItem = UITabBarItem(title: "", image: UIImage(named: "32_reddit"), selectedImage: nil)
        firstTabItem.tag = 0
        firstController.tabBarItem = firstTabItem
        let secondController = DemoViewController1()
        let secondTabItem = UITabBarItem(title: "", image: UIImage(named: "32_tinder"), selectedImage: nil)
        secondTabItem.tag = 1
        secondController.tabBarItem = secondTabItem
        let thirdController = DemoViewController2()
        let thirdTabItem = UITabBarItem(title: "", image: UIImage(named: "32_tumblr"), selectedImage: nil)
        thirdTabItem.tag = 2
        thirdController.tabBarItem = thirdTabItem
        viewControllers = [firstController, secondController, thirdController]
    }
    
    private func setupAnimationBall() {
        animationItem = UIImageView(frame: CGRect(x: self.view.bounds.width/6-25, y: -20, width: 50, height: 50))
        animationItem.contentMode = .center
        animationItem.image = UIImage(named: "32_tinder")?.withTintColor(UIColor(named: "DeepSaffron")!)
        animationItem.backgroundColor = UIColor(named: "GlossyGrape")
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
    private func updateAnimationBarFrame() {
        UIView.animate(withDuration: 1) { [unowned self] in
            if self.selectedIndex == 0 {
                self.animationItem.frame = CGRect(x: self.view.bounds.width/6-25, y: -20, width: 50, height: 50)
                animationItem.image = UIImage(named: "32_reddit")?.withTintColor(UIColor(named: "DeepSaffron")!)
            } else if self.selectedIndex == 1 {
                self.animationItem.frame = CGRect(x: (self.view.bounds.width*3/6)-25, y: -20, width: 50, height: 50)
                animationItem.image = UIImage(named: "32_tinder")?.withTintColor(UIColor(named: "DeepSaffron")!)
            } else if self.selectedIndex == 2 {
                self.animationItem.frame = CGRect(x: (self.view.bounds.width*5/6)-25, y: -20, width: 50, height: 50)
                animationItem.image = UIImage(named: "32_tumblr")?.withTintColor(UIColor(named: "DeepSaffron")!)
            }
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
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = TimeInterval(1)
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        opacityAnimation.fillMode = .forwards
        opacityAnimation.isRemovedOnCompletion = true
        imageView.layer.add(opacityAnimation, forKey: "iconOpacity")
        imageView.layer.opacity = 0
    }
    
    fileprivate func addShowAnimation(_ otherShownImage: [UIImageView]) {
        for image in otherShownImage where image.alpha == 0 {
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 0
            opacityAnimation.toValue = 1
            opacityAnimation.duration = TimeInterval(1)
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            opacityAnimation.fillMode = .forwards
            opacityAnimation.isRemovedOnCompletion = true
            image.layer.add(opacityAnimation, forKey: "iconOpacity")
            image.layer.opacity = 1
        }
    }
    
    // MARK: - Private Properties
    private var animationItem = UIImageView()
}

extension TroughAnimationTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.selectedIndex = item.tag
    }
}
