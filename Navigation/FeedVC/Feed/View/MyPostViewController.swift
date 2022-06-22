//
//  PostViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit

class MyPostViewController: UIViewController {
    
    private var viewModel: MyPostViewModel?
    private weak var postCoordinator: MyPostCoordinator?

    private var timerLeft = 25
    private var timer: Timer?
    
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        timerLabel.toAutoLayout()
        timerLabel.text = "Через \(String(timerLeft)) секунд появистя что-то!"
        timerLabel.textAlignment = .center
        timerLabel.textColor = .black
        
        return timerLabel
    }()
    
    private lazy var timerImage: UIImageView = {
        let timerImage = UIImageView()
        timerImage.toAutoLayout()
        timerImage.contentMode = .scaleAspectFill
        
        return timerImage
    }()
    
    init (viewModel: MyPostViewModel, coordinator: MyPostCoordinator) {
        self.viewModel = viewModel
        self.postCoordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(addTapped))
        
        self.view.addSubviews(timerLabel, timerImage)
        
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        timerImage.widthAnchor.constraint(equalToConstant: 250).isActive = true
        timerImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        timerImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
    }
    
//    //MARK: - Метод отсчета времени
//    @objc func onTimerFires() {
//        timerLeft -= 1
//        timerLabel.text = "Через \(String(timerLeft)) секунд появистя что-то!"
//
//        if timerLeft <= 0 {
//            timer?.invalidate()
//            timer = nil
//            self.timerImage.image = UIImage(named: "kin-dza-dza")
//
//        }
//    }
//
    @objc func addTapped() {
        let coordinator = InfoCoordinator()
        
        coordinator.showDetail(navigation: self.navigationController, coordinator: coordinator)
        
       
       


        
     
    }
}
