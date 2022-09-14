//
//  LogInViewController.swift
//  Navigation
//
//  Created by Shom on 06.03.2022.
//

import UIKit
//import FirebaseAuth
//import FirebaseDatabase
//import RealmSwift


class LogInViewController: UIViewController, UITextFieldDelegate {
    
    public var delegate: LoginViewControllerDelegate?
    private let myInspector = Factory.shared.myFactory()
    //var logins: Results<LoginModel>?
    var localAuth = LocalAuthorizationService()

    
    private var isLogined: Bool? {
        willSet {
            if newValue! {
                logInButton.setTitle("Вход по Face ID", for: .normal)
                brutePassword.setTitle("Сначала пройдите регистрацию! Нажми сюда!", for: .normal)
            } else {
                logInButton.setTitle("Нажмите для регистрации", for: .normal)
                brutePassword.setTitle("Регистрация готова? Нажмите", for: .normal)
            }
        }
    }
    
    //MARK: create view objects
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        //contentView.backgroundColor = .white
        contentView.toAutoLayout()
        return contentView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.toAutoLayout()
        return logoImageView
    }()
    
    private lazy var userNameTextField: UITextField = {
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
    
    private lazy var passwordTextField: UITextField = {
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
    
    private lazy var stackView: UIStackView = {
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
        let logInButton = CustomButton(title: "",
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
        let brutePassword = CustomButton(title: "", titleColor: .lightGray, backColor: .white)
        
        brutePassword.toAutoLayout()
        brutePassword.imageView?.contentMode = .scaleAspectFill
        brutePassword.clipsToBounds = true
        brutePassword.layer.cornerRadius = 10
        brutePassword.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)
        brutePassword.addTarget(self, action: #selector(switchLogin), for: .touchUpInside)
        
        return brutePassword
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //subviews add in contentView
        contentView.addSubviews(logoImageView, stackView, logInButton, brutePassword)
        
        isLogined = true
        
        //кнопка возврата от profileVC
        navigationController?.navigationBar.isHidden = true
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        self.delegate = myInspector
        
        //        Auth.auth().addStateDidChangeListener { auth, user in
        //            if user != nil {
        //
        //            }
        //        }
        
        //settings view
        self.view.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)

        
        logInButton.tapAction = { [weak self] in
            guard self != nil else { return } //guard let self = self else { return }

            //self.logInApp()
        }
        
        //contentView add scrollView
        scrollView.addSubviews(contentView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: max(view.frame.width, view.frame.height))
        
        //add textField in stackView
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        //MARK: Keyboard close in tap view
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        initialLayout()
        
    }
    
    //MARK: view up (keyboard) and settings scrollView
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Заглушка для пропуска автоизации
         //        let coordinator = ProfileCoordinator()
         //        let profileViewController = coordinator.showDetail(coordinator: coordinator)
         //        self.navigationController?.pushViewController(profileViewController, animated: true)
         //        self.navigationController?.setViewControllers([profileViewController], animated: true)
                 
        
        //        if let newData = self.logins?[0] {
        //            authentification(newData.login, newData.password)
        //        }
        registerKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    //custom alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Initial constraints
    
    private func initialLayout() {
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
                                     brutePassword.heightAnchor.constraint(equalToConstant: 50)
                                    ])
    }
    
    //MARK: Navigation segue
    @objc private func goToProfileVC() {
        //logInApp()
        
        
        localAuth.authorizeIfPossible { success in
            if success {
                DispatchQueue.main.async {
                    let coordinator = ProfileCoordinator()
                    let profileViewController = coordinator.showDetail(coordinator: coordinator)
                    self.navigationController?.pushViewController(profileViewController, animated: true)
                    self.navigationController?.setViewControllers([profileViewController], animated: true)
                }

            }
        }
    }
    
    @objc private func switchLogin() {
        isLogined!.toggle()
    }
    
    //    //Realm save data
    //    func logInApp() {
    //
    //        guard let dataLogin = userNameTextField.text,
    //              let dataPassword = passwordTextField.text else { return }
    //        let data = LoginModel(value: [dataLogin, dataPassword])
    //        do {
    //            let realm = try Realm()
    //            try realm.write { realm.add(data) }
    //        } catch let error {
    //            print(error.localizedDescription)
    //        }
    //
    //        //login
    //        authentification(dataLogin, dataPassword)
    //    }
    
    //Login app
    func authentification(_ login: String, _ password: String) {
        guard let newDelegate = self.delegate else { return }
        DispatchQueue.main.async {
            newDelegate.checker(loginType: self.isLogined! ? .signIn : .SignUp,
                                logTF: login,
                                passTF: password)
        }
    }
    
    func textFieldIndicator (subView: UIView) -> UIView {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(subView)
        subView.center = leftView.center
        return leftView
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
