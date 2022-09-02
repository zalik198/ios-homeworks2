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
    var coordinator: InfoCoordinator?
    
    
    private lazy var secondButton: CustomButton = {
        let secondButton = CustomButton(title: NSLocalizedString("infoButton", comment: ""),
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
    
    private lazy var jsonDecodingLabel: UILabel = {
        let jsonDecodingLabel = UILabel()
        jsonDecodingLabel.toAutoLayout()
        jsonDecodingLabel.layer.cornerRadius = 2
        jsonDecodingLabel.layer.borderWidth = 1
        jsonDecodingLabel.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        jsonDecodingLabel.textAlignment = .center
        
        return jsonDecodingLabel
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
        self.view.addSubviews(serializationLabel, secondButton, jsonDecodingLabel)
        self.initialLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        urlSessionDataTask()
        myPlanet()
    }
    
    //ДЗ 2
    //Часть 1
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
    
    //ДЗ 2
    //Часть 2
    func myPlanet() {
        if let url = URL(string: "https://swapi.dev/api/planets/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let newPlanet = parseJSON(withData: data) {
                        DispatchQueue.main.async {
                            self.jsonDecodingLabel.text = newPlanet.orbitalPeriod
                        }
                    }
                }
            }
            task.resume()
        }
        
        //parsing JSON
        func parseJSON(withData data: Data) -> MyPlanet? {
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(Planet.self, from: data)
                let myPlanet = MyPlanet(myPlanet: user)
                return myPlanet
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            return nil
        }
    }
    
    private func initialLayout() {
        serializationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(25)
            make.height.equalTo(50)
            make.width.equalToSuperview()
            
        }
        
        jsonDecodingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.serializationLabel).offset(100)
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        
        secondButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.jsonDecodingLabel).offset(150)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
     
    }
    
    @objc func showAlert() {
        
        let alert = UIAlertController(title: NSLocalizedString("infoAlertTitle", comment: ""), message: NSLocalizedString("infoAlertMessage", comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("infoAlertActionTitleLeft", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
            print(NSLocalizedString("infoAlertActionLeftPrint", comment: ""))
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("infoAlertActionTitleRight", comment: ""),
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
            print(NSLocalizedString("infoAlerActionRightPrint", comment: ""))
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
