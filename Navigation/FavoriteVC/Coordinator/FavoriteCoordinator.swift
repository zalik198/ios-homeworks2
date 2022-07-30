//
//  FavoriteCoordinator.swift
//  Navigation
//
//  Created by Shom on 21.07.2022.
//

import Foundation
import UIKit

final class FavoriteCoordinator {
    func showDetail(coordinator: FavoriteCoordinator) -> UIViewController {
        let viewModel = CoreDataManager()
        let viewController = FavoriteViewController(model: viewModel, coordinator: coordinator)
        viewController.title = "Favorite"
        return viewController
    }
}
