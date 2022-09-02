//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import Foundation
import UIKit

//var navControl: UINavigationController?

class InfoCoordinator {
    

    func showDetail(navigation: UINavigationController?, coordinator: InfoCoordinator) {
        let viewModel = InfoViewModel()
        let viewController = InfoViewController(viewModel: viewModel, coordinator: coordinator)
        viewController.title = "info.title".localized
        viewController.view.backgroundColor = .lightGray
        navigation?.pushViewController(viewController, animated: true)
    }
}
