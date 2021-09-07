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
    
    // MARK: - Private Properties
    private func initSubComponents() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        imgView.contentMode = .scaleAspectFit
    }
    
    private func addSubComponents() {
        addSubview(highlightView)
        addSubview(titleLabel)
        addSubview(imgView)
    }
    
    private func layoutSubComponents() {
        highlightView.frame = CGRect(x: 0, y: 10, width: bounds.width, height: bounds.height-20)
        imgView.frame = CGRect(x: 15, y: (bounds.height-30)/2, width: 30, height: 30)
        titleLabel.frame = CGRect(x: 50, y: (bounds.height-25)/2, width: bounds.width-60, height: 25)
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
        model.isSelected = isSelected
        let options: UIView.AnimationOptions = isSelected ? [.curveEaseIn] : [.curveEaseOut]
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: options,
                       animations: {
            self.titleLabel.text = isSelected ? model.title : ""
            let color = isSelected ? self.higlightBGColor : .white
            self.highlightView.backgroundColor = color
            (self.superview as? UIStackView)?.layoutIfNeeded()
        }, completion: nil)
    }

    // MARK: - Private Properties
    private var titleLabel = UILabel()
    private var imgView = UIImageView()
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
