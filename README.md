# CustomTabBar
 CustomTabBar with animation

### Fill Icon Animation
#### Add Five animation type for icon fill color:
 - Fill from left to right
 - Fill from right to left
 - Fill from top to bottom
 - Fill from bottom to top
 - Fill from center to extend

![Icon Fill Animation](https://github.com/seamusapple/CustomTabBar/blob/main/Fill%20Icon%20Animation.gif)

### Custom Tab Bar Controller 1
#### Usage
```
let tabBarController = RootStackTabViewController()
tabBarController.viewControllers = [ViewController(), DemoViewController(), DemoViewController1(), DemoViewController2()]
tabBarController.tabModels = [
    BottomStackItem(title: "Password", image: "48_1password", highlightColor: UIColor(named: "CaribbeanGreen"), unhighlightColor: UIColor.white),
    BottomStackItem(title: "Photo", image: "48_photo", highlightColor: UIColor(named: "BlueJeans"), unhighlightColor: UIColor.white),
    BottomStackItem(title: "Shortcuts", image: "48_shortcuts", highlightColor: UIColor(named: "YelloCrayola"), unhighlightColor: UIColor.white),
    BottomStackItem(title: "Vsco", image: "48_vsco", highlightColor: UIColor(named: "Rose"), unhighlightColor: UIColor.white)]
]
tabBarController.tabBackColor = UIColor(named: "DarkWorld")
window.rootViewController = tabBarController
```

![ExtendTabBar Animation](https://github.com/seamusapple/CustomTabBar/blob/main/ExtendTabBarAnimation.gif)

### Custom Tab Bar Controller 2
```
let tabBarController = TroughAnimationTabBarController()
    
let firstController = DemoViewController()
firstController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_reddit"), selectedImage: nil)
    
let secondController = DemoViewController1()
secondController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_tinder"), selectedImage: nil)
    
let thirdController = DemoViewController2()
thirdController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_tumblr"), selectedImage: nil)
    
let forthController = ViewController()
forthController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "32_facebook"), selectedImage: nil)
    
tabBarController.viewControllers = [firstController, secondController, thirdController, forthController]

/// Please set your init selectedIndex after you set viewControllers.
tabBarController.selectedIndex = 1
tabBarController.tabBarBackgroundColor = UIColor(named: "CaribbeanGreen")!
tabBarController.highlightTabIconColor = UIColor(named: "DarkWorld")!
tabBarController.highlightAnimationType = .dropRise
tabBarController.ballCornerRadius = 25
tabBarController.ballOffset = 20
tabBarController.ballSize = CGSize(width: 50, height: 50)
tabBarController.troughExtend = 60
    
window.rootViewController = tabBarController
```
![TroughBallTabBar Animation](https://github.com/seamusapple/CustomTabBar/blob/main/TroughBallTabBar%20Animation.gif)