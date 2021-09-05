//
//  FillAnimationView.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/5/21.
//

import UIKit

class FillAnimationView: UIView {
    // MARK: - Public Properties
    var fillColor = UIColor(named: "DeepSaffron") {
        didSet { fillAnimationView.backgroundColor = fillColor }
    }
    var image: UIImage? {
        didSet { backImageView.image = image }
    }
    var animationView: UIView {
        get { return fillAnimationView }
    }
    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubComponents()
        addSubComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Super override
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backImageView.frame = bounds
        fillAnimationView.frame = bounds
        fillAnimationView.frame.origin.y = bounds.height
    }
    
    // MARK: - Private Properties
    private func initSubComponents() {
        layer.masksToBounds = true
        backgroundColor = .black
        self.backImageView.contentMode = .scaleAspectFit
        self.mask = backImageView
    }
    
    private func addSubComponents() {
        addSubview(fillAnimationView)
    }
    
    // MARK: - Private Properties
    private let fillAnimationView = UIView()
    private let backImageView = UIImageView()
}
