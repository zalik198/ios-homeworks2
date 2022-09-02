//
//  MyPostCoordinator.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import Foundation
import UIKit

final class MyPostCoordinator {
    func showDetail(navigation: UINavigationController?, coordinator: MyPostCoordinator) {
        let viewModel = MyPostViewModel()
        let viewController = MyPostViewController(viewModel: viewModel, coordinator: coordinator)
        viewController.view.backgroundColor = .systemGray5
        viewController.title = "post.title".localized
        navigation?.pushViewController(viewController, animated: true)
    }
}
