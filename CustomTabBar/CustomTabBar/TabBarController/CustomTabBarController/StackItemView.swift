//
//  StackItemView.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/7/21.
//

import UIKit

protocol StackItemViewDelegate: AnyObject {
    func handleTap(_ view: StackItemView)
}

class StackItemView: UIView {
    
    // MARK: - Public Methods
    
    // MARK: - Public Properties
    weak var delegate: StackItemViewDelegate?
    var higlightBGColor = UIColor(named: "CaribbeanGreen")
    var isIconFillAnimation = false
    var isSelected: Bool = false {
        willSet { self.updateUI(isSelected: newValue) }
    }
    var item: Any? {
        didSet { self.configure(self.item) }
    }
    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTapGesture()
        initSubComponents()
        addSubComponents()
        layoutSubComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Super Override
    override func layoutMarginsDidChange() {
        highlightView.layer.cornerRadius = (bounds.height-20-safeAreaInsets.bottom)/2
    }
    
    // MARK: - Private Properties
    private func initSubComponents() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        highlightView.layer.cornerRadius = 40
    }
    
    private func addSubComponents() {
        addSubview(highlightView)
        addSubview(titleLabel)
        addSubview(imgView)
    }
    
    private func layoutSubComponents() {
        addConstraints([
            NSLayoutConstraint(item: highlightView, attribute: .top, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: highlightView, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: highlightView, attribute: .left, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: highlightView, attribute: .right, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0),
        ])
        addConstraints([
            NSLayoutConstraint(item: imgView, attribute: .centerY, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imgView, attribute: .left, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: imgView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: imgView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        ])
        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: imgView, attribute: .right, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: -10)
        ])
        
    }
    
    // MARK: - Event Response
    
    // MARK: - Private Methods
    private func configure(_ item: Any?) {
        guard let model = item as? BottomStackItem else { return }
        self.titleLabel.text = model.title
        self.imgView.image = UIImage(named: model.image)
        self.isSelected = model.isSelected
    }
    
    private func updateUI(isSelected: Bool) {
        guard let model = item as? BottomStackItem else { return }
        self.imgView.fillColor = isSelected ? UIColor(named: "DeepSaffron") : UIColor.clear
        if isIconFillAnimation {
            let imgAnimator = ViewAnimator(animation: ViewAnimation.fillCenterwards(duration: 0.4, delay: 0).getAnimation())
            imgAnimator.animated(fillColorView: self.imgView.animationView, animatedView: self.imgView)
        } else {
            isSelected ? self.imgView.fillImageWithoutAnimation() : self.imgView.unfillImageWithoutAnimation()
        }
        model.isSelected = isSelected
        let options: UIView.AnimationOptions = isSelected ? [.curveEaseIn] : [.curveEaseOut]
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: options,
                       animations: {
                        self.titleLabel.text = isSelected ? model.title : ""
                        self.titleLabel.textColor = isSelected ? UIColor(named: "DeepSaffron") : UIColor.black
                        self.titleLabel.font = isSelected ? UIFont(name: "AvenirNext-Bold", size: 16) : UIFont(name: "AvenirNext-Regular", size: 16)
                        let color = isSelected ? self.higlightBGColor : .white
                        self.highlightView.backgroundColor = color
                        (self.superview as? UIStackView)?.layoutIfNeeded()
                       }, completion: nil)
    }

    // MARK: - Private Properties
    private var titleLabel = UILabel()
    private var imgView = FillAnimationView()
    private var highlightView = UIView()
}

extension StackItemView {
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleGesture(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleGesture(_ sender: UITapGestureRecognizer) {
        self.delegate?.handleTap(self)
    }
    
}
