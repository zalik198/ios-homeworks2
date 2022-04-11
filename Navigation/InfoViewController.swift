//
//  InfoViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let secondButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
        secondButton.center = self.view.center
        secondButton.backgroundColor = .magenta
        secondButton.setTitle("Сообщение", for: .normal)
        secondButton.setTitleColor(.black, for: .normal)
        secondButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        self.view.addSubview(secondButton)
    }
    
    @objc func showAlert() {
        
        let alert = UIAlertController(title: "Внимание!", message: "Вам исполнилось 18 лет?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: UIAlertAction.Style.default, handler: { _ in
            print("Да, мне уже исполнилось 18 лет!")
        }))
        alert.addAction(UIAlertAction(title: "Нет",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
            print("Нет, мне еще нет 18 лет!")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
