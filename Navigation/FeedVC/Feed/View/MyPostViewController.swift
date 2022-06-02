//
//  PostViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class MyPostViewController: UIViewController {
    
    private var viewModel: MyPostViewModel?
    private weak var coordinator: MyPostCoordinator?
        
    init (viewModel: MyPostViewModel, coordinator: MyPostCoordinator) {
         self.viewModel = viewModel
         self.coordinator = coordinator
         super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let coordinator = InfoCoordinator()
            coordinator.showDetail(navigation: navigationController, coordinator: coordinator)
    }
}
