//
//  File.swift
//  Navigation
//
//  Created by Shom on 17.02.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private var statusText = ""
    
    //MARK: Initial views
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ostap"))
        imageView.toAutoLayout()
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userName: UILabel = {
        let userName = UILabel()
        userName.toAutoLayout()
        userName.text = "Остап Ибрагимович"
        userName.textAlignment = .left
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return userName
    }()
    
    let showStatus: UIButton = {
        let showStatus = UIButton()
        showStatus.toAutoLayout()
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
    
    let status: UILabel = {
        let status = UILabel()
        status.toAutoLayout()
        status.text = "Рога и копыта!"
        status.textAlignment = .natural
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.isUserInteractionEnabled = true
        return status
    }()
    
    let statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.toAutoLayout()
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        statusTextField.addTarget(self, action: #selector(setStatus), for: .editingChanged)
        return statusTextField
    }()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(imageView, userName, showStatus, status, statusTextField)
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Initial constraints
    private func initialLayout() {
        toAutoLayout()
        
        [
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            userName.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant:  -16),
            
            status.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            status.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            status.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -5),
            
            showStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            showStatus.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            showStatus.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            showStatus.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.bottomAnchor.constraint(equalTo: showStatus.topAnchor, constant: -10),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
        ]
            .forEach { $0.isActive = true }
    }
    
    //MARK: buttons tapped
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
