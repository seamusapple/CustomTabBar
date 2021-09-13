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
        troughTabBar.animationTabBar()
        updateAnimationBarFrame()
        updateItemImage()
    }
    
    // MARK: - Private Methods
    private func initSubComponents() {
        setupTabBar()
        setupControllers()
        setupAnimationBall()
        self.delegate = self
        self.selectedIndex = 1
        addObserver(self, forKeyPath: "selectedIndex", options: .new, context: nil)
        guard self.tabBar is TroughAnimationTabBar else { return }
        let troughTabBar = self.tabBar as! TroughAnimationTabBar
        troughTabBar.currentSelectedIndex = 1
        troughTabBar.nextIndex = 1
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
        animationItem = UIImageView(frame: CGRect(x: (self.view.bounds.width/2)-25, y: -20, width: 50, height: 50))
        animationItem.contentMode = .scaleAspectFit
        animationItem.image = UIImage(named: "32_tinder")?.withTintColor(UIColor(named: "DeepSaffron")!)
        animationItem.backgroundColor = UIColor(named: "GlossyGrape")
        animationItem.layer.shadowColor = UIColor.black.cgColor
        animationItem.layer.shadowOpacity = 0.15
        animationItem.layer.shadowRadius = 2
        animationItem.layer.shadowOffset = CGSize(width: 0, height: 4)
        animationItem.layer.cornerRadius = 25
        
        self.tabBar.addSubview(animationItem)
    }
    
    // MARK: - Event Responses
    
    // MARK: - Private Methods
    private func updateAnimationBarFrame() {
        if self.selectedIndex == 0 {
            animationItem.frame = CGRect(x: self.view.bounds.width/6-25, y: -20, width: 50, height: 50)
        } else if self.selectedIndex == 1 {
            animationItem.frame = CGRect(x: (self.view.bounds.width*3/6)-25, y: -20, width: 50, height: 50)
        } else if self.selectedIndex == 2 {
            animationItem.frame = CGRect(x: (self.view.bounds.width*5/6)-25, y: -20, width: 50, height: 50)
        }
    }
    
    private func updateItemImage() {
        if self.selectedIndex == 0 {
            animationItem.image = UIImage(named: "32_reddit")?.withTintColor(UIColor(named: "DeepSaffron")!)
            self.tabBar.items?.first?.image = nil
            self.tabBar.items?[1].image = UIImage(named: "32_tinder")
            self.tabBar.items?[2].image = UIImage(named: "32_tumblr")
        } else if self.selectedIndex == 1 {
            animationItem.image = UIImage(named: "32_tinder")?.withTintColor(UIColor(named: "DeepSaffron")!)
            self.tabBar.items?.first?.image = UIImage(named: "32_reddit")
            self.tabBar.items?[1].image = nil
            self.tabBar.items?[2].image = UIImage(named: "32_tumblr")
        } else if self.selectedIndex == 2 {
            animationItem.image = UIImage(named: "32_tumblr")?.withTintColor(UIColor(named: "DeepSaffron")!)
            self.tabBar.items?.first?.image = UIImage(named: "32_reddit")
            self.tabBar.items?[1].image = UIImage(named: "32_tinder")
            self.tabBar.items?[2].image = nil
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
