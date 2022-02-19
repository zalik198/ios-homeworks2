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
        profileHeaderView.initialViews()
        
        self.view.backgroundColor = .lightGray
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(profileHeaderView)

        

    }
    
    override func viewWillLayoutSubviews() {
        self.view.subviews.first?.frame = self.view.frame
        
    }
    

    

}
