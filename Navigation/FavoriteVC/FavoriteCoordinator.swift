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
        let viewController = FavoriteViewController()
        viewController.title = "Favorite"
        return viewController
    }
}
