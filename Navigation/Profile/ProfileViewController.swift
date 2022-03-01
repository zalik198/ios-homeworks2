//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let newButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Новый заголовок"
        let profileHeaderView = ProfileHeaderView()
        view.addSubview(profileHeaderView)
        profileHeaderView.initialSubviews()
        
        self.view.backgroundColor = .lightGray
        
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.layer.cornerRadius = 5
        newButton.backgroundColor = .systemBlue
        newButton.setTitle("Установить заголовок", for: .normal)
        newButton.addTarget(self, action: #selector(setTitle), for: .touchUpInside)
        self.view.addSubview(newButton)
        
        newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        newButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func setTitle() {
        if title == "Новый заголовок"{
            title = "Лед тронулся, господа!"
        } else {
            title = "Лед тронулся, господа!"
        }
    }
}
