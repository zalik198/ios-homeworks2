//
//  FeedViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = MyPost(title: "Newsline")
    let myPostViewController: MyPostViewController
    
    init() {
        myPostViewController = MyPostViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.addChild(myPostViewController)
        
        let firstButton: UIButton = {
            let firstButton = UIButton()
            firstButton.backgroundColor = .darkGray
            firstButton.layer.cornerRadius = 15
            firstButton.layer.borderWidth = 3
            firstButton.layer.borderColor = UIColor.white.cgColor
            firstButton.setTitle("Первая кнопка", for: .normal)
            firstButton.setTitleColor(.black, for: .normal)
            firstButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
            return firstButton
        }()
        
        let secondButton: UIButton = {
            let secondButton = UIButton()
            secondButton.backgroundColor = .white
            secondButton.layer.borderWidth = 3
            secondButton.layer.borderColor = UIColor.darkGray.cgColor
            secondButton.layer.cornerRadius = 15
            secondButton.setTitle("Вторая кнопка", for: .normal)
            secondButton.setTitleColor(.black, for: .normal)
            secondButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
            return secondButton
        }()
        
        let stackView: UIStackView = {
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
        
        self.view.addSubview(stackView)
        
        let horizontalConstraint = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = stackView.widthAnchor.constraint(equalToConstant: 150)
        let heightConstraint = stackView.heightAnchor.constraint(equalToConstant: 150)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    @objc func showNews() {
        myPostViewController.title = post.title
        self.navigationController?.pushViewController(myPostViewController, animated: true)
    }
}
