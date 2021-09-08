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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init Methods
    
    // MARK: - Super Override
    
    // MARK: - Private Methods
    private func initSubComponents() {
        tabBackView.translatesAutoresizingMaskIntoConstraints = false
        tabBackView.backgroundColor = .green
        tabContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabContainerView.backgroundColor = .gray
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
    
    // MARK: - Event Responses
    
    // MARK: - Private Methods
    
    // MARK: - Private Properties
    private let tabBackView = UIView()
    private let tabContainerView = UIStackView()
}
