//
//  SceneDelegate.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/5/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        configRootAsTroughBallAnimationTabController(window)
        
//        configRootAsExtendAnimationTabController(window)
        
        self.window = window
        window.makeKeyAndVisible()
    }

    private func configRootAsTroughBallAnimationTabController(_ window: UIWindow) {
        let rootViewController = TroughAnimationTabBarController()
        rootViewController.selectedIndex = 1
        let firstController = DemoViewController()
        firstController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_reddit"), selectedImage: nil)
        let secondController = DemoViewController1()
        secondController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_tinder"), selectedImage: nil)
        let thirdController = DemoViewController2()
        thirdController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_tumblr"), selectedImage: nil)
        let forthController = ViewController()
        forthController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_facebook"), selectedImage: nil)
        rootViewController.viewControllers = [firstController, secondController, thirdController, forthController]
        rootViewController.tabBarBackgroundColor = UIColor(named: "CaribbeanGreen")!
        rootViewController.highlightTabIconColor = UIColor(named: "DarkWorld")!
        rootViewController.highlightAnimationType = .dropRise
        rootViewController.ballCornerRadius = 25
        rootViewController.ballOffset = 20
        rootViewController.ballSize = CGSize(width: 50, height: 50)
        rootViewController.troughExtend = 60
        window.rootViewController = rootViewController
    }
    
    private func configRootAsExtendAnimationTabController(_ window: UIWindow) {
        let rootViewController = RootStackTabViewController()
        rootViewController.viewControllers = [ViewController(), DemoViewController(), DemoViewController1(), DemoViewController2()]
        rootViewController.tabModels = [
            BottomStackItem(title: "Password", image: "48_1password", highlightColor: UIColor(named: "CaribbeanGreen"), unhighlightColor: UIColor.white),
            BottomStackItem(title: "Photo", image: "48_photo", highlightColor: UIColor(named: "BlueJeans"), unhighlightColor: UIColor.white),
            BottomStackItem(title: "Shortcuts", image: "48_shortcuts", highlightColor: UIColor(named: "YelloCrayola"), unhighlightColor: UIColor.white),
            BottomStackItem(title: "Vsco", image: "48_vsco", highlightColor: UIColor(named: "Rose"), unhighlightColor: UIColor.white)
        ]
        rootViewController.tabBackColor = UIColor(named: "DarkWorld")
        window.rootViewController = rootViewController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

