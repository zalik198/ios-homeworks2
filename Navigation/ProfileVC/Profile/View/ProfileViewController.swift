//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Shom on 10.02.2022.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel?
    private weak var coordinator: ProfileCoordinator?
    
    var posts = ProfileViewModel().postArray
    private let userData: UserService
    private let userName: String
    
    private var cellIndex = 0
    
    init(userData: UserService, userName: String, viewModel: ProfileViewModel, coordinator: ProfileCoordinator) {
        self.userData = userData
        self.userName = userName
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Initial tableView
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.refreshControl = UIRefreshControl()
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        
#if DEBUG
        tableView.backgroundColor = .lightGray
#elseif release
        tableView.backgroundColor = .white
#endif
        
        view.addSubviews(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "profile")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postTableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "photosTableViewCell")
        
        initialLayout()
        
    }
    
    //MARK: Initial constraints
    
    func initialLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func duobleTapInPost() {
        guard let post = viewModel?.postArray[self.cellIndex] else { return }
        
        var isContains = false
        
        for i in CoreDataManager.shared.favoritePost {
            if i.id == post.id {
                isContains = true
            }
        }
        
        if !isContains {
            CoreDataManager.shared.saveToCoreData(post: post)
        } else {
            print("error contains")
        }
    }
    
}

//MARK: Initial TableView Deegate and DataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "photosTableViewCell", for: indexPath) as! PhotosTableViewCell
            return cell
            
        }
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as? PostTableViewCell
        let tapRecog = UITapGestureRecognizer(target: self, action: #selector(duobleTapInPost))
        tapRecog.numberOfTapsRequired = 2
        
        
        guard let tableViewMyCell = cell, let myViewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = myViewModel.cellViewModel(forIndexPath: indexPath)
        tableViewMyCell.viewModel = cellViewModel
        tableViewMyCell.addGestureRecognizer(tapRecog)
        //cell.myCells(post: posts[indexPath.row])
        return tableViewMyCell
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "profile") as! ProfileHeaderView
            if let user = userData.userSetup(userName) {
                view.setupUserData(user: user)
            }
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0
        }
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        } else {
            self.cellIndex = indexPath.row
        }
    }
    
}
