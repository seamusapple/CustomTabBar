//
//  FillAnimationView.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/5/21.
//

import UIKit

extension UIView {
    private static var _needReAlignFillAnimationView = [String: Bool]()
    
    var needReAlignFillAnimationView: Bool {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIView._needReAlignFillAnimationView[tmpAddress] ?? false
        }
        
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIView._needReAlignFillAnimationView[tmpAddress] = newValue
        }
    }
}

class FillAnimationView: UIView {
    // MARK: - Public Methods
    func fillImageWithoutAnimation() {
        fillAnimationView.frame = bounds
    }
    
    func unfillImageWithoutAnimation() {
        fillAnimationView.frame = CGRect.zero
    }
    
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
        guard !needReAlignFillAnimationView else { return }
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
