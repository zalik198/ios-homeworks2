//
//  PostViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

struct Post {
    var title: String
}

class PostViewController: UIViewController {
    
    var infoViewController: InfoViewController
    
    init() {
        infoViewController = InfoViewController()
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
        present(infoViewController, animated: true, completion: nil)
        
    }
    
    }
