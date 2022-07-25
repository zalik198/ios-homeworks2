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
    
    private let myInspector = Factory.shared.myFactory()
    
    //MARK: Initial tableView
    private var tableView: UITableView = {
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
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        initialLayout()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "favoriteTableViewCell")

        
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
    
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
