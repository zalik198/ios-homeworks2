//
//  Support.swift
//  Navigation
//
//  Created by Shom on 07.03.2022.
//

import UIKit

public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
}
