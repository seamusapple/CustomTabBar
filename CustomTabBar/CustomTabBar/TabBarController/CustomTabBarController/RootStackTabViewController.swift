//
//  RootStackTabViewController.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/7/21.
//

import UIKit

class RootStackTabViewController: UIViewController {
    // MARK: - Public Methods
    
    // MARK: - Public Properties
    var currentIndex = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubComponents()
        addSubComponents()
        layoutSubComponents()
        setupTabs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handleTap(self.tabs[self.currentIndex])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init Methods
    
    // MARK: - Super Override
    
    // MARK: - Private Methods
    private func initSubComponents() {
        view.backgroundColor = UIColor(named: "GlossyGrape")
        tabBackView.translatesAutoresizingMaskIntoConstraints = false
        tabBackView.backgroundColor = .white
        tabContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabContainerView.backgroundColor = .clear
        tabContainerView.distribution = .equalSpacing
        tabContainerView.alignment = .fill
        tabContainerView.spacing = 0
        tabContainerView.axis = .horizontal
    }
    
    private func addSubComponents() {
        view.addSubview(tabBackView)
        tabBackView.addSubview(tabContainerView)
    }
    
    private func layoutSubComponents() {
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
    
    // MARK: - Event Responses
    
    // MARK: - Private Methods
    
    // MARK: - Private Properties
    private let tabBackView = UIView()
    private let tabContainerView = UIStackView()
    
    lazy var tabs: [StackItemView] = {
        var items = [StackItemView]()
        for _ in 0..<5 {
            items.append(StackItemView())
        }
        return items
    }()
    
    lazy var tabModels: [BottomStackItem] = {
        return [
            BottomStackItem(title: "Password", image: "48_1password"),
            BottomStackItem(title: "Photo", image: "48_photo"),
            BottomStackItem(title: "Shortcuts", image: "48_shortcuts"),
            BottomStackItem(title: "Vsco", image: "48_vsco")
        ]
    }()
}

extension RootStackTabViewController: StackItemViewDelegate {
    func handleTap(_ view: StackItemView) {
        self.tabs[self.currentIndex].isSelected = false
        view.isSelected = true
        self.currentIndex = self.tabs.firstIndex(where: { $0 === view }) ?? 0
    }
}
