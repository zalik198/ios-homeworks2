//
//  LogInViewController.swift
//  Navigation
//
//  Created by Shom on 06.03.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    let profileVC = ProfileViewController()
    
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
        userNameTextField.placeholder = "Email or phone"
        userNameTextField.keyboardType = .emailAddress
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userNameTextField.frame.height))
        userNameTextField.leftViewMode = .always
        userNameTextField.autocapitalizationType = .none
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        return userNameTextField
    }()
    
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.toAutoLayout()
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.tintColor = UIColor(named: "AccentColor")
        passwordTextField.placeholder = "Password"
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.isSecureTextEntry = true
        
        return passwordTextField
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        stackView.distribution = .fillProportionally
        stackView.clipsToBounds = true
        
        return stackView
    }()
    
    var logInButton: UIButton = {
        let logInButton = UIButton()
        
        if let pixelImage = UIImage(named: "blue_pixel") {
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 1), for: .normal)
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .selected)
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .highlighted)
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .disabled)
            
        }
        
        logInButton.toAutoLayout()
        logInButton.setTitle("Log In", for: .normal)
        logInButton.imageView?.contentMode = .scaleAspectFill
        logInButton.titleLabel?.textColor = .white
        logInButton.clipsToBounds = true
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(goToProfileVC), for: .touchUpInside)
        
        return logInButton
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        
        contentView.addSubviews(logoImageView, stackView, logInButton)
        
        scrollView.addSubview(contentView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: max(view.frame.width, view.frame.height))
        
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        
        
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
                                     logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     
                                     stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
                                     stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     stackView.heightAnchor.constraint(equalToConstant: 100),
                                     
                                     logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
                                     logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     logInButton.heightAnchor.constraint(equalToConstant: 50)
                                    ])
        
    }
    
    @objc func goToProfileVC() {
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    
}

extension UIImage {
    func imageWithAlpha(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
