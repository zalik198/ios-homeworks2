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

        let firstButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        firstButton.center = self.view.center
        firstButton.backgroundColor = .orange
        firstButton.setTitle("Новость", for: .normal)
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.addTarget(self, action: #selector(showNews), for: .touchUpInside)
        self.view.addSubview(firstButton)
    }
    

  @objc func showNews() {
      postViewController.title = post.title
      self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
