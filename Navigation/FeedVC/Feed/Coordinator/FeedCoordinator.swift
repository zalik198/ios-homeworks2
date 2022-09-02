//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import UIKit
import Foundation

final class FeedCoordinator {
    func showDetail(coordinator: FeedCoordinator) -> UIViewController {
        let viewModel = FeedViewModel()
        let viewController = FeedViewController(model: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .lightGray
        viewController.title = "feed.title".localized
        return viewController
    }
}



