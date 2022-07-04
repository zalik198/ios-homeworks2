//
//  LogInViewController.swift
//  Navigation
//
//  Created by Shom on 06.03.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var delegate: LoginViewControllerDelegate?
    private let myInspector = Factory.shared.myFactory()
    
    
    //MARK: create view objects
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.toAutoLayout()
        return contentView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.toAutoLayout()
        return logoImageView
    }()
    
    lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.toAutoLayout()
        userNameTextField.textColor = .black
        userNameTextField.font = UIFont.systemFont(ofSize: 16)
        userNameTextField.tintColor = UIColor(named: "AccentColor")
        userNameTextField.placeholder = "Email or phone"
        userNameTextField.keyboardType = .emailAddress
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userNameTextField.frame.height))
        userNameTextField.leftViewMode = .always
        userNameTextField.returnKeyType = .done
        userNameTextField.autocapitalizationType = .none
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        return userNameTextField
    }()
    
    lazy var passwordTextField: UITextField = {
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
        passwordTextField.returnKeyType = .done
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.isSecureTextEntry = true
        
        return passwordTextField
    }()
    
    lazy var stackView: UIStackView = {
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
    
    private lazy var logInButton: CustomButton = {
        let logInButton = CustomButton(title: "Log In",
                                       titleColor: .white,
                                       backColor: .white)
        //setting alpha logInButton
        if let pixelImage = UIImage(named: "blue_pixel") {
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 1), for: .normal)
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .selected)
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .highlighted)
            logInButton.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .disabled)
        }
        logInButton.toAutoLayout()
        logInButton.imageView?.contentMode = .scaleAspectFill
        logInButton.clipsToBounds = true
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(goToProfileVC), for: .touchUpInside)
        
        return logInButton
    }()
    
    private lazy var brutePassword: CustomButton = {
        let brutePassword = CustomButton(title: "Log on", titleColor: .white, backColor: .white)
        if let pixelImage = UIImage(named: "blue_pixel") {
            brutePassword.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 1), for: .normal)
            brutePassword.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .selected)
            brutePassword.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .highlighted)
            brutePassword.setBackgroundImage(pixelImage.imageWithAlpha(alpha: 0.8), for: .disabled)
        }
        
        brutePassword.toAutoLayout()
        brutePassword.imageView?.contentMode = .scaleAspectFill
        brutePassword.clipsToBounds = true
        brutePassword.layer.cornerRadius = 10
        brutePassword.addTarget(self, action: #selector(passwordCrack), for: .touchUpInside)
        
        return brutePassword
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //кнопка возврата от profileVC
        navigationController?.navigationBar.isHidden = true
        
        //settings view
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        //contentView add scrollView
        scrollView.addSubviews(contentView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: max(view.frame.width, view.frame.height))
        
        //subviews add in contentView
        contentView.addSubviews(logoImageView, stackView, logInButton, brutePassword)
        
        //add textField in stackView
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        //MARK: Keyboard close in tap view
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        initialLayout()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        self.delegate = myInspector
        
        
    }
    
    func logOnApp() {
        
        if(!userNameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty) {
            Auth.auth().createUser(withEmail: userNameTextField.text!, password: passwordTextField.text!) { result, error in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                        let ref = Database.database().reference().child("user")
                        ref.child(result.user.uid).updateChildValues(
                            ["login" : self.userNameTextField.text!,
                             "password" : self.passwordTextField.text!])
                    }
                }  else if self.passwordTextField.text!.count < 6 {
                    self.showAlert(title: "Внимание!", message: "Пароль должен состоять минимум из 6 символов!")
                } else if result == result {
                    self.showAlert(title: "Внимание", message: "Данный пользователь уже зарегистрирован! Войдите в свою учетную запись")
                }
            }
        } else {
            showAlert(title: "Внимание!", message: "Введите данные!")
        }
        
        
    }
    
    func logInApp() {
        let coordinator = ProfileCoordinator()
        let profileViewController = coordinator.showDetail(coordinator: coordinator)
        
        Auth.auth().signIn(withEmail: userNameTextField.text!, password: passwordTextField.text!) { [self] result, error in
            if error == nil {
                self.navigationController?.pushViewController(profileViewController, animated: true)
            } else if userNameTextField.text!.isEmpty {
                self.showAlert(title: "Внимание!", message: "Введите данные!")
            } else if result?.user.uid == result?.user.uid {
                self.showAlert(title: "Внимание", message: "Неверный логин или пароль!")
            } else {
                self.showAlert(title: "Внимание!", message: "Снчала пройдите регистрацию!")
            }
        }
    }
    
    //custom alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Initial constraints
    
    func initialLayout() {
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 150),
                                     
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
                                     logInButton.heightAnchor.constraint(equalToConstant: 50),
                                     
                                     brutePassword.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
                                     brutePassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     brutePassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     brutePassword.heightAnchor.constraint(equalToConstant: 50),
                                    ])
    }
    
    //MARK: Navigation segue
    @objc private func goToProfileVC() {
        logInApp()
    }
    
    //BrutForce
    @objc private func passwordCrack() {
        
        logOnApp()
    }
    
    func textFieldIndicator (subView: UIView) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(subView)
        subView.center = leftView.center
        return leftView
    }
    
    //MARK: view up (keyboard) and settings scrollView
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 150, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Extension for UIImageView
extension UIImage {
    func imageWithAlpha(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
