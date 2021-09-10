//
//  RootStackTabViewController.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/7/21.
//

import UIKit

extension UIWindow {
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}

class RootStackTabViewController: UIViewController {
    // MARK: - Public Methods
    
    // MARK: - Public Properties
    var currentIndex = 0
    var viewControllers: [UIViewController] = []
    var tabModels: [BottomStackItem] = []
    var tabBackColor: UIColor? = .white 
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubComponents()
        addSubComponents()
        layoutSubComponents()
        setupTabs()
        setupController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard self.currentIndex < self.tabs.count-1 else { return }
        updateController(with: nil, tabItemView: self.tabs[self.currentIndex])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init Methods
    
    // MARK: - Super Override
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { _ in
            if UIWindow.isLandscape {
                
            } else {
                
            }
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // MARK: - Private Methods
    private func initSubComponents() {
        view.backgroundColor = .clear
        controllerContainerView.backgroundColor = .clear
        controllerContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabBackView.translatesAutoresizingMaskIntoConstraints = false
        tabBackView.backgroundColor = tabBackColor
        tabContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabContainerView.backgroundColor = .clear
        tabContainerView.distribution = .equalSpacing
        tabContainerView.alignment = .fill
        tabContainerView.spacing = 0
        tabContainerView.axis = .horizontal
    }
    
    private func addSubComponents() {
        view.addSubview(controllerContainerView)
        view.addSubview(tabBackView)
        tabBackView.addSubview(tabContainerView)
    }
    
    private func layoutSubComponents() {
        view.addConstraints([
            NSLayoutConstraint(item: controllerContainerView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: controllerContainerView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: controllerContainerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: controllerContainerView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.88, constant: 0)
        ])
        view.addConstraints([
            NSLayoutConstraint(item: tabBackView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBackView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBackView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabBackView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.12, constant: 0)
        ])
        tabBackView.addConstraints([
            NSLayoutConstraint(item: tabContainerView, attribute: .left, relatedBy: .equal, toItem: tabBackView, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: tabContainerView, attribute: .right, relatedBy: .equal, toItem: tabBackView, attribute: .right, multiplier: 1, constant: -15),
            NSLayoutConstraint(item: tabContainerView, attribute: .top, relatedBy: .equal, toItem: tabBackView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tabContainerView, attribute: .bottom, relatedBy: .equal, toItem: tabBackView, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    private func setupTabs() {
        for (index, model) in self.tabModels.enumerated() {
            let tabView = self.tabs[index]
            model.isSelected = index == currentIndex
            tabView.item = model
            tabView.delegate = self
            self.tabContainerView.addArrangedSubview(tabView)
        }
    }
    
    private func setupController(with previousIndex: Int? = nil) {
        if let previous = previousIndex, previous < self.viewControllers.count {
            let previousVC = self.viewControllers[previous]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        
        guard self.currentIndex < self.viewControllers.count else { return }
        let newVC = viewControllers[self.currentIndex]
        self.addChild(newVC)
        newVC.view.frame = self.controllerContainerView.bounds
        self.controllerContainerView.addSubview(newVC.view)
        newVC.didMove(toParent: self)
    }
    
    // MARK: - Event Responses
    
    // MARK: - Private Methods
    private func updateController(with previousIndex: Int?, tabItemView: StackItemView) {
        tabItemView.isSelected = true
        setupController(with: previousIndex)
    }
    
    // MARK: - Private Properties
    private let tabBackView = UIView()
    private let tabContainerView = UIStackView()
    private let controllerContainerView = UIView()
    
    private lazy var tabs: [StackItemView] = {
        var items = [StackItemView]()
        for tabModel in tabModels {
            let stackItemView = StackItemView()
            stackItemView.higlightBGColor = tabModel.highlightColor?.withAlphaComponent(0.2)
            stackItemView.unhighlightBGColor = tabModel.unhighlightColor
            items.append(stackItemView)
        }
        return items
    }()
}

extension RootStackTabViewController: StackItemViewDelegate {
    func handleTap(_ view: StackItemView) {
        let previousIndex = self.currentIndex
        let newIndex = self.tabs.firstIndex(where: { $0 === view }) ?? 0
        guard previousIndex != newIndex else { return }
        self.tabs[previousIndex].isSelected = false
        self.currentIndex = newIndex
        updateController(with: previousIndex, tabItemView: view)
    }
}
