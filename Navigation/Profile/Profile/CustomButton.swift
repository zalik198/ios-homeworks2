//
//  CustomButton.swift
//  Navigation
//
//  Created by Shom on 20.05.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    let title: String
    let titleColor: UIColor
    let backColor: UIColor
    
    var tapAction: (() -> Void)?
    
    
    init(title: String, titleColor: UIColor, backColor: UIColor) {
        self.title = title
        self.titleColor = titleColor
        self.backColor = backColor
        
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = backColor
        layer.cornerRadius = 10
        clipsToBounds = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        tapAction?()
    }
    
    
    
    
}
