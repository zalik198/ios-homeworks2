//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import UIKit
import Foundation

final class ProfileCoordinator {
    func showDetail(coordinator: ProfileCoordinator) -> UIViewController {
    let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(
            userData: TestUserService() as UserService,
            userName: "admin",
            viewModel: viewModel,
            coordinator: coordinator)
        //viewController.view.backgroundColor = .white
        viewController.title = "profile.title".localized
        return viewController
    }
}

