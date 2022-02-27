//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileHeaderView = ProfileHeaderView()
        view.addSubview(profileHeaderView)
        profileHeaderView.initialViews()


        //profileHeaderView.initialLayout()
        
        self.view.backgroundColor = .lightGray
    }

}
