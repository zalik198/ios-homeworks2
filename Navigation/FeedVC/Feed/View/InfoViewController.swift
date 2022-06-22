//
//  InfoViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    private var viewModel: InfoViewModel?
    private weak var coordinator: InfoCoordinator?
    private var jsonSerialization: JSONSerializationManager?
    
    private lazy var secondButton: CustomButton = {
        let secondButton = CustomButton(title: "Сообщение",
                                        titleColor: .black,
                                        backColor: .orange)
       
        secondButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return secondButton
    }()
    
    private lazy var serializationLabel: UILabel = {
       let serializationLabel = UILabel()
        serializationLabel.toAutoLayout()
        serializationLabel.layer.cornerRadius = 2
        serializationLabel.layer.borderWidth = 1
        serializationLabel.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        serializationLabel.textAlignment = .center
    
        return serializationLabel
    }()
    
    init (viewModel: InfoViewModel, coordinator: InfoCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        //self.view.backgroundColor = .white
        self.view.addSubviews(serializationLabel, secondButton)
        
      
        
        self.initialLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        urlSessionDataTask()
    }
    
    //Добавил его сюда, чтобы сразу использовать title
    func urlSessionDataTask() {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                do {
                    
                    if let data = data {
                        let decodeData = try JSONSerialization.jsonObject(with: data, options: [])
                        print(decodeData)
                        
                        if let dict = decodeData as? [String: Any],
                           let title = dict["title"] as? String {
                            DispatchQueue.main.async {
                                self.serializationLabel.text = title
                            }
                        }
                    }
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    private func initialLayout() {
        serializationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(25)
            make.height.equalTo(50)
            make.width.equalToSuperview()

        }
        
        secondButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.serializationLabel).offset(150)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
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
