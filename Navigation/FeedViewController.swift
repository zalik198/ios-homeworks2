//
//  FeedViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Newsline")
    let postViewController: PostViewController
    
    init() {
        postViewController = PostViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.addChild(postViewController)
        
        let firstButton: UIButton = {
            let myFirstButton = UIButton()
            myFirstButton.backgroundColor = .darkGray
            myFirstButton.layer.cornerRadius = 15
            myFirstButton.layer.borderWidth = 3
            myFirstButton.layer.borderColor = UIColor.white.cgColor
            myFirstButton.setTitle("Первая кнопка", for: .normal)
            myFirstButton.setTitleColor(.black, for: .normal)
            myFirstButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
            return myFirstButton
        }()
        
        let secondButton: UIButton = {
            let mySecondButton = UIButton()
            mySecondButton.backgroundColor = .white
            mySecondButton.layer.borderWidth = 3
            mySecondButton.layer.borderColor = UIColor.darkGray.cgColor
            mySecondButton.layer.cornerRadius = 15
            mySecondButton.setTitle("Вторая кнопка", for: .normal)
            mySecondButton.setTitleColor(.black, for: .normal)
            mySecondButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
            return mySecondButton
        }()
        
        let stackView: UIStackView = {
            let myStackView = UIStackView()
            myStackView.axis = .vertical
            myStackView.spacing = 10
            myStackView.distribution = .fillEqually
            myStackView.alignment = .fill
            myStackView.addArrangedSubview(firstButton)
            myStackView.addArrangedSubview(secondButton)
            myStackView.translatesAutoresizingMaskIntoConstraints = false
            return myStackView
        }()
        
        self.view.addSubview(stackView)
        
        let horizontalConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = stackView.widthAnchor.constraint(equalToConstant: 150)
        let heightConstraint = stackView.heightAnchor.constraint(equalToConstant: 150)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    @objc func showNews() {
        postViewController.title = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
