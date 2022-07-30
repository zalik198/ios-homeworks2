//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Shom on 21.07.2022.
//

import Foundation
import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    private var viewModel: CoreDataManager?
    private weak var coordinator: FavoriteCoordinator?
    private var post: PostData?
    private let myInspector = Factory.shared.myFactory()
    
    //MARK: Initial tableView
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.refreshControl = UIRefreshControl()
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        //tableView.estimatedSectionHeaderHeight = 220
        //tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    
    init(model: CoreDataManager, coordinator: FavoriteCoordinator ) {
        self.viewModel = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        initialLayout()
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "favoriteTableViewCell")

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoreDataManager.shared.outFromCoreData()
        tableView.reloadData()
    }
    
    //MARK: Initial constraints
    
    func initialLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
    
 
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.favoritePost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        let post = CoreDataManager.shared.favoritePost[indexPath.row]
        cell.myCells(post)
        return cell
    }
    
    
}
