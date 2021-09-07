//
//  BottomStackItem.swift
//  CustomTabBar
//
//  Created by Ramsey on 9/7/21.
//

class BottomStackItem {
    // MARK: - Init Methods
    init(title: String,
         image: String,
         isSelected: Bool = false) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
    }
    
    // MARK: - Private Properties
    var title: String
    var image: String
    var isSelected : Bool
}
