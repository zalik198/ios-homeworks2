//
//  FeedViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    private var viewModel: FeedViewModel?
    private weak var coordinator: FeedCoordinator?
    
    //var post = MyPost(title: NSLocalizedString("feed.title", comment: ""))
    
    init (model: FeedViewModel, coordinator: FeedCoordinator) {
        self.viewModel = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var firstButton: CustomButton = {
        let firstButton = CustomButton(title: NSLocalizedString("feedFirstButton", comment: ""),
                                       titleColor: .white,
                                       backColor: .darkGray)
        firstButton.layer.cornerRadius = 15
        firstButton.layer.borderWidth = 3
        firstButton.layer.borderColor = UIColor.white.cgColor
        firstButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
        return firstButton
    }()
    
    private lazy var secondButton: CustomButton = {
        let secondButton = CustomButton(title: NSLocalizedString("feedSecondButton", comment: ""),
                                        titleColor: .black,
                                        backColor: .white)
        secondButton.layer.borderWidth = 3
        secondButton.layer.borderColor = UIColor.darkGray.cgColor
        secondButton.layer.cornerRadius = 15
        secondButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
        return secondButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.toAutoLayout()
        return stackView
    }()
    
    
    //MARK: Model check password
    private lazy var newButton: CustomButton = {
        let newButton = CustomButton(title: NSLocalizedString("feedCheckPass", comment: ""),
                                     titleColor: .black,
                                     backColor: .white)
        newButton.layer.borderWidth = 3
        return newButton
    }()
    
    private lazy var newTextField: UITextField = {
        let newTextField = UITextField()
        newTextField.placeholder = NSLocalizedString("feedEnterPass", comment: "")
        newTextField.textColor = .black
        newTextField.isSecureTextEntry = true
        newTextField.backgroundColor = .white
        newTextField.clipsToBounds = true
        newTextField.layer.cornerRadius = 10
        newTextField.font = UIFont.systemFont(ofSize: 17)
        newTextField.leftViewMode = .always
        newTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: newTextField.frame.height))
        return newTextField
    }()
    
    private lazy var newLabel: UILabel = {
        let newLabel = UILabel()
        newLabel.backgroundColor = .white
        newLabel.textAlignment = .center
        
        return newLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(stackView, newButton, newTextField, newLabel)
        initialLayout()
        
        newButton.tapAction = {  [weak self ] in
            guard let self = self else { return }
            self.newButtonAction()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(redLabel), name: NSNotification.Name.red, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(greenLabel), name: NSNotification.Name.green, object: nil)
        
        //MARK: - Таймер отсчета времени, перед оповещением!
//        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
//            let alert = UIAlertController(title: "Просто напоминание!", message: "Приложение ждет Вас!", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    private func initialLayout() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(25)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        newTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        newButton.snp.makeConstraints { make in
            make.top.equalTo(newTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        newLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
    }
    
    @objc func redLabel() {
        newLabel.text = NSLocalizedString("feedRedLabel", comment: "")
        newLabel.textColor = .red
    }
    
    @objc func greenLabel() {
        newLabel.text = NSLocalizedString("feedGreenLabel", comment: "")
        newLabel.textColor = .green
    }
    
    private func newButtonAction() {
        viewModel!.check(word: newTextField.text!)
    }
    
    @objc func showNews() {
        let coordinator = MyPostCoordinator()
        coordinator.showDetail(navigation: navigationController, coordinator: coordinator)
        
    }
}
