//
//  LogInViewController.swift
//  Navigation
//
//  Created by Shom on 06.03.2022.
//

import UIKit

class LogInViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.toAutoLayout()
        return contentView
    }()
    
    let logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.toAutoLayout()
        return logoImageView
    }()
    
    let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.toAutoLayout()
        userNameTextField.textColor = .black
        userNameTextField.font = UIFont.systemFont(ofSize: 16)
        userNameTextField.tintColor = UIColor(named: "AccentColor")
        userNameTextField.autocapitalizationType = .none
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        userNameTextField.layer.borderWidth = 0.5
        
        return userNameTextField
    }()
    
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.toAutoLayout()
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.tintColor = UIColor(named: "AccentColor")
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5

        return passwordTextField
    }()
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: max(view.frame.width, view.frame.height))
        contentView.addSubviews(logoImageView)
        
        scrollView.addSubview(contentView)
        
        
   
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     
                                     contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                                     contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                                     contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                                     
                                     logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
                                     logoImageView.widthAnchor.constraint(equalToConstant: 100),
                                     logoImageView.heightAnchor.constraint(equalToConstant: 100),
                                     logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
                                    ])
        
        
        
        
        
    }
    
    
    
    

}
