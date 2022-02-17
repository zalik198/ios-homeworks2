//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        
        //profileHeaderView.backgroundColor = .purple
        self.view.addSubview(profileHeaderView)
     

    }
    
    override func viewWillLayoutSubviews() {

        profileHeaderView.frame = self.view.frame
        
        
    }
    

    

}
