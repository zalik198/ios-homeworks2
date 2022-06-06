//
//  Support.swift
//  Navigation
//
//  Created by Shom on 07.03.2022.
//

import UIKit
import StorageService

let appearance = UINavigationBarAppearance()

public var photosArray = [UIImage(named: "3+2")!, UIImage(named: "brilliant")!, UIImage(named: "buratino")!, UIImage(named: "gentlman")!, UIImage(named: "golubi")!, UIImage(named: "ironia")!, UIImage(named: "ivanVasilievich")!, UIImage(named: "kin-dza")!, UIImage(named: "mestoVstrechi")!, UIImage(named: "moskva")!, UIImage(named: "operationY")!, UIImage(named: "roman")!, UIImage(named: "samogon")!, UIImage(named: "skazka")!, UIImage(named: "solnce")!, UIImage(named: "sportloto")!, UIImage(named: "stariki")!, UIImage(named: "svadba")!, UIImage(named: "troeVLodke")!, UIImage(named: "vokzal")!]

public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
}

