//
//  File.swift
//  Navigation
//
//  Created by Shom on 17.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var imageView: UIImageView
    var userName: UILabel
    var showStatus: UIButton
    var status: UILabel
    var statusTextField: UITextField
    private var statusText = ""
    
    init() {
        imageView = UIImageView(image: UIImage(named: "ostap"))
        showStatus = UIButton()
        userName = UILabel()
        status = UILabel()
        statusTextField = UITextField()
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Остап Ибрагимович"
        userName.textAlignment = .left
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.addSubview(userName)
        
        showStatus.translatesAutoresizingMaskIntoConstraints = false
        showStatus.layer.cornerRadius = 4
        showStatus.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatus.layer.shadowRadius = 4
        showStatus.layer.shadowColor = UIColor.black.cgColor
        showStatus.layer.shadowOpacity = 0.7
        showStatus.layer.backgroundColor = UIColor.systemBlue.cgColor
        showStatus.setTitle("Show status", for: .normal)
        showStatus.setTitleColor(UIColor.white, for: .normal)
        self.addSubview(showStatus)
        self.showStatus.addTarget(self, action: #selector(buttonShow), for: .touchUpInside)
        
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Рога и копыта!"
        status.textAlignment = .natural
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.isUserInteractionEnabled = true
        self.addSubview(status)
        
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        statusTextField.addTarget(self, action: #selector(setStatus), for: .editingChanged)
        self.addSubview(statusTextField)
        
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
    
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            userName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            userName.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant:  -16),
            
            status.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            status.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -16),
            status.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -5),
            
            showStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            showStatus.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -16),
            showStatus.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            showStatus.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.bottomAnchor.constraint(equalTo: showStatus.topAnchor, constant: -10),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
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
        status.text = newText
    }
}
