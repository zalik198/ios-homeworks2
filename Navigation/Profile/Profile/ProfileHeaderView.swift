//
//  File.swift
//  Navigation
//
//  Created by Shom on 17.02.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    
    private var statusText = ""
    
    //MARK: Initial views
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ostap"))
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        imageView.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapInImage))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var closeImageButton: UIButton = {
        let closeImageButton = UIButton()
        closeImageButton.isHidden = true
        closeImageButton.imageView?.contentMode = .scaleAspectFit
        closeImageButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeImageButton.backgroundColor = .gray
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapCloseImage))
        closeImageButton.addGestureRecognizer(tap)
        closeImageButton.isUserInteractionEnabled = true
        closeImageButton.tintColor = .black
        return closeImageButton
    }()
    
    let alphaView: UIView = {
        let alphaView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        alphaView.toAutoLayout()
        alphaView.isUserInteractionEnabled = true
        alphaView.backgroundColor = .systemGray
        alphaView.isHidden = true
        alphaView.alpha = 0
        return alphaView
    }()
    
    let userName: UILabel = {
        let userName = UILabel()
        userName.text = "Остап Ибрагимович"
        userName.textAlignment = .left
        userName.textColor = .black
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return userName
    }()
    
    let showStatus: UIButton = {
        let showStatus = UIButton()
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
        status.text = "Рога и копыта!"
        status.textAlignment = .natural
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = .gray
        status.isUserInteractionEnabled = true
        return status
    }()
    
    let statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        statusTextField.addTarget(self, action: #selector(setStatus), for: .editingChanged)
        return statusTextField
    }()
    
    var defaultPlaceImage: CGPoint?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(userName, showStatus, status, statusTextField, alphaView, imageView, closeImageButton)
        initialLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUser(user: User) {
        userName.text = user.name
        imageView.image = user.avatar
        status.text = user.status
    }
    //MARK: Initial constraints
    private func initialLayout() {
        imageView.snp.makeConstraints({ make in
            make.top.leading.equalTo(16)
            make.width.height.equalTo(100)
        })
        userName.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).inset(-20)
            make.top.equalTo(27)
            make.trailing.equalTo(-16)
        }
        status.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(statusTextField.snp.top).inset(-5)
        }
        showStatus.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-16)
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        statusTextField.snp.makeConstraints { make in
            make.bottom.equalTo(showStatus.snp.top).offset(-10)
            make.height.equalTo(40)
            make.trailing.equalTo(-16)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        closeImageButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(0)
            make.height.width.equalTo(25)
        }
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
    
    //MARK: TapGestureInImage
    @objc func tapInImage() {
        UIView.animate(withDuration: 0.5, animations: {
            self.defaultPlaceImage = self.imageView.center
            self.imageView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            self.imageView.transform = CGAffineTransform(scaleX: self.contentView.frame.width / self.imageView.frame.width,
                                                         y: self.contentView.frame.width / self.imageView.frame.width)
            self.imageView.isUserInteractionEnabled = false
            self.imageView.layer.borderWidth = 0
            self.imageView.layer.cornerRadius = 0
            //self.showStatus.alpha = 0
            self.alphaView.isHidden = false
            self.alphaView.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeImageButton.isHidden = false
                self.closeImageButton.alpha = 1
            }
        }
    }
    
    @objc func tapCloseImage() {
        UIView.animate(withDuration: 0.3, animations: {
            self.closeImageButton.isHidden = true
            self.closeImageButton.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.imageView.layer.borderWidth = 3
                self.imageView.layer.cornerRadius = 50
                self.imageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
                self.imageView.clipsToBounds = true
                self.imageView.center = self.defaultPlaceImage ?? CGPoint(x: 1, y: 1)
                self.alphaView.isHidden = true
                self.alphaView.alpha = 0
            }
        }
    }
}
