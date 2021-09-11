//
//  CustomTabBarController.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/11/21.
//

import UIKit

class CustomTabBarController: UITabBarController {

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
        self.delegate = self
        self.selectedIndex = 1
        setupTabBar()
        setupControllers()
        setupMiddleTabItem()
    }
    
    private func setupTabBar() {
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    private func setupControllers() {
        let firstController = DemoViewController()
        firstController.tabBarItem = UITabBarItem(title: "Screen1", image: nil, selectedImage: nil)
        let secondController = DemoViewController1()
        secondController.tabBarItem = UITabBarItem(title: "", image: nil, selectedImage: nil)
        let thirdController = DemoViewController2()
        thirdController.tabBarItem = UITabBarItem(title: "Screen3", image: nil, selectedImage: nil)
        viewControllers = [firstController, secondController, thirdController]
    }
    
    private func setupMiddleTabItem() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width/2)-25, y: -20, width: 50, height: 50))
        middleButton.setBackgroundImage(UIImage(named: "50_camera"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        middleButton.addTarget(self, action: #selector(middleButtonAction(sender:)), for: .touchUpInside)
        
        self.tabBar.addSubview(middleButton)
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Event Responses
    @objc private func middleButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
    
    // MARK: - Private Methods
    
    // MARK: - Private Properties
    
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
}
