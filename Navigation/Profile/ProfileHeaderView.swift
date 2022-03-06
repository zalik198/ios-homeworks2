//
//  File.swift
//  Navigation
//
//  Created by Shom on 17.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText = ""
    
    let fullImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ostap"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let fullUserName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Остап Ибрагимович"
        userName.textAlignment = .left
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return userName
    }()
    
    let fullShowStatus: UIButton = {
        let showStatus = UIButton()
        showStatus.translatesAutoresizingMaskIntoConstraints = false
        showStatus.layer.cornerRadius = 4
        showStatus.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatus.layer.shadowRadius = 4
        showStatus.layer.shadowColor = UIColor.black.cgColor
        showStatus.layer.shadowOpacity = 0.7
        showStatus.layer.backgroundColor = UIColor.systemBlue.cgColor
        showStatus.setTitle("Show status", for: .normal)
        showStatus.setTitleColor(UIColor.white, for: .normal)
        showStatus.addTarget(self, action: #selector(buttonShow), for: .touchUpInside)
        
        return showStatus
    }()
    
    let fullStatus: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Рога и копыта!"
        status.textAlignment = .natural
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.isUserInteractionEnabled = true
        
        return status
    }()
    
    let fullStatusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        statusTextField.addTarget(self, action: #selector(setStatus), for: .editingChanged)
        
        return statusTextField
    }()
    
    func initialSubviews() {
        self.addSubview(fullImageView)
        self.addSubview(fullUserName)
        self.addSubview(fullShowStatus)
        self.addSubview(fullStatus)
        self.addSubview(fullStatusTextField)
        
        initialLayout()
    }
    
    private func initialLayout() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        guard let superView = superview else { return }
        
        [
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            self.heightAnchor.constraint(equalToConstant: 220),
            
            fullImageView.widthAnchor.constraint(equalToConstant: 100),
            fullImageView.heightAnchor.constraint(equalTo: fullImageView.widthAnchor),
            fullImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            fullImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            fullUserName.leadingAnchor.constraint(equalTo: fullImageView.trailingAnchor, constant: 20),
            fullUserName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullUserName.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant:  -16),
            
            fullStatus.leadingAnchor.constraint(equalTo: fullImageView.trailingAnchor, constant: 20),
            fullStatus.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -16),
            fullStatus.bottomAnchor.constraint(equalTo: fullStatusTextField.topAnchor, constant: -5),
            
            fullShowStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            fullShowStatus.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -16),
            fullShowStatus.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 16),
            fullShowStatus.heightAnchor.constraint(equalToConstant: 50),
            
            fullStatusTextField.bottomAnchor.constraint(equalTo: fullShowStatus.topAnchor, constant: -10),
            fullStatusTextField.heightAnchor.constraint(equalToConstant: 40),
            fullStatusTextField.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -16),
            fullStatusTextField.leadingAnchor.constraint(equalTo: fullImageView.trailingAnchor, constant: 20)
        ]
            .forEach { $0.isActive = true }
    }
    
    @objc func setStatus(_ textField: UITextField) {
        if let text = textField.text {
            statusText = text
        }
    }
    @objc func buttonShow() {
        let newText = statusText
        fullStatus.text = newText
    }
}
