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
    
    // MARK: - Private Methods
    private func initSubComponents() {
        setupTabBar()
        setupControllers()
        setupAnimationBall()
        self.delegate = self
        self.selectedIndex = 1
        guard self.tabBar is TroughAnimationTabBar else { return }
        let troughTabBar = self.tabBar as! TroughAnimationTabBar
        troughTabBar.currentSelectedIndex = 1
        view.layoutIfNeeded()
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
        let secondTabItem = UITabBarItem(title: "", image: nil, selectedImage: nil)
        secondTabItem.tag = 1
        secondController.tabBarItem = secondTabItem
        let thirdController = DemoViewController2()
        let thirdTabItem = UITabBarItem(title: "", image: UIImage(named: "32_tumblr"), selectedImage: nil)
        thirdTabItem.tag = 2
        thirdController.tabBarItem = thirdTabItem
        viewControllers = [firstController, secondController, thirdController]
    }
    
    private func setupAnimationBall() {
        animationButton = UIButton(frame: CGRect(x: (self.view.bounds.width/2)-25, y: -20, width: 50, height: 50))
        animationButton.setImage(UIImage(named: "32_tinder"), for: .normal)
        animationButton.setImage(UIImage(named: "32_tinder")?.withTintColor(UIColor(named: "DeepSaffron")!, renderingMode: .alwaysTemplate), for: .selected)
        animationButton.layer.shadowColor = UIColor.black.cgColor
        animationButton.layer.shadowOpacity = 0.15
        animationButton.layer.shadowRadius = 2
        animationButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        animationButton.imageView?.contentMode = .scaleAspectFit
        animationButton.isSelected = true
        animationButton.backgroundColor = UIColor(named: "GlossyGrape")
        animationButton.layer.cornerRadius = 25
        animationButton.addTarget(self, action: #selector(animationButtonAction(sender:)), for: .touchUpInside)
        
        self.tabBar.addSubview(animationButton)
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Event Responses
    @objc private func animationButtonAction(sender: UIButton) {
        sender.isSelected = true
        self.selectedIndex = 1
        guard self.tabBar is TroughAnimationTabBar else { return }
        let troughTabBar = self.tabBar as! TroughAnimationTabBar
        troughTabBar.currentSelectedIndex = self.selectedIndex
        troughTabBar.nextIndex = 1
        troughTabBar.animationTabBar()
    }
    
    // MARK: - Private Methods
    
    // MARK: - Private Properties
    private var animationButton = UIButton()
}

extension TroughAnimationTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag != 1 {
            animationButton.isSelected = false
        } else {
            animationButton.isSelected = true
        }
        guard self.tabBar is TroughAnimationTabBar else { return }
        let troughTabBar = self.tabBar as! TroughAnimationTabBar
        troughTabBar.currentSelectedIndex = self.selectedIndex
        troughTabBar.nextIndex = item.tag
        troughTabBar.animationTabBar()
    }
}
