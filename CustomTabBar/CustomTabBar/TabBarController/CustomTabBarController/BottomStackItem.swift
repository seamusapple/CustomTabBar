//
//  BottomStackItem.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/7/21.
//
 import UIKit

class BottomStackItem {
    // MARK: - Init Methods
    init(title: String,
         image: String,
         highlightColor: UIColor? = UIColor.black,
         unhighlightColor: UIColor? = UIColor.black,
         isSelected: Bool = false) {
        self.title = title
        self.image = image
        self.highlightColor = highlightColor
        self.unhighlightColor = unhighlightColor
        self.isSelected = isSelected
    }
    
    // MARK: - Private Properties
    var title: String
    var image: String
    var highlightColor: UIColor?
    var unhighlightColor: UIColor?
    var isSelected : Bool
}
