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
        
        let firstButton = UIButton()
        firstButton.backgroundColor = .blue
        firstButton.layer.cornerRadius = 25
        firstButton.setTitle("Первая кнопка", for: .normal)
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
        
        let secondButton = UIButton()
        secondButton.backgroundColor = .red
        secondButton.layer.cornerRadius = 25
        secondButton.setTitle("Вторая кнопка", for: .normal)
        secondButton.setTitleColor(.black, for: .normal)
        secondButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
