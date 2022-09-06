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
    private var textFieldBottomConstraint: NSLayoutConstraint?
    public var favoritePost = [PostData]()
    var manageObjectContext: NSManagedObjectContext!
    private var fetchResultController: NSFetchedResultsController<NSFetchRequestResult>?
    
    lazy var textFieldPanel: UIView = {
        let view = UIView(frame: CGRect(x: 0.0, y: self.view.bounds.height, width: self.view.bounds.width, height: 75))
        self.view.addSubview(view)
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.75
        
        let fieldBottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        textFieldBottomConstraint = fieldBottomConstraint
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(.init(item: view, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(.init(item: view, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(fieldBottomConstraint)
        self.view.addConstraint(.init(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 75))
        
        return view
    }()
    
    lazy var textField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 50.0))
        textFieldPanel.addSubview(field)
        
        //field.backgroundColor = .lightGray
        field.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(.init(item: field, attribute: .left, relatedBy: .equal, toItem: textFieldPanel, attribute: .left, multiplier: 1.0, constant: 8.0))
        self.view.addConstraint(.init(item: field, attribute: .right, relatedBy: .equal, toItem: textFieldPanel, attribute: .right, multiplier: 1.0, constant: -8.0))
        self.view.addConstraint(.init(item: field, attribute: .top, relatedBy: .equal, toItem: textFieldPanel, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(.init(item: field, attribute: .bottom, relatedBy: .equal, toItem: textFieldPanel, attribute: .bottom, multiplier: 1.0, constant: -50.0))
        
        return field
    }()
    
    lazy var buttonInTextField: UIButton = {
        let buttonInTextField = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25.0))
        textFieldPanel.addSubview(buttonInTextField)
        
        buttonInTextField.setTitle("Применить", for: .normal)
        buttonInTextField.backgroundColor = .systemBlue
        buttonInTextField.layer.cornerRadius = 10
        
        buttonInTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(.init(item: buttonInTextField, attribute: .left, relatedBy: .equal, toItem: textFieldPanel, attribute: .left, multiplier: 1.0, constant: 40.0))
        self.view.addConstraint(.init(item: buttonInTextField, attribute: .right, relatedBy: .equal, toItem: textFieldPanel, attribute: .right, multiplier: 1.0, constant: -40.0))
        self.view.addConstraint(.init(item: buttonInTextField, attribute: .bottom, relatedBy: .equal, toItem: textFieldPanel, attribute: .bottom, multiplier: 1.0, constant: -3.0))
        
        
        return buttonInTextField
    }()
    
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
        //fetchResult.delegate = self
        initialLayout()
        self.view.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)
        self.tableView.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)
        
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "favoriteTableViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(cancelFilteredSearchAction))
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
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
    
    //доработать поиск по автору
    @objc func searchAction() {
        
        let alertController = UIAlertController(title: "Search author post", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter author"
        }
        
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: { alert -> Void in
            if let textFileds = alertController.textFields {
                let newTextFiled = textFileds as [UITextField]
                let enterText = newTextFiled[0].text
                self.fetchFilter(enterText ?? "")
                self.tableView.reloadData()
            }
            //            let textField = alertController.textFields?[0]
            //            //let secondTextField = alertController.textFields![1] as UITextField
            //            if let text = textField?.text, text != "" {
            //                self.fetchFilter(text)
            //            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        
        //        alertController.addTextField { (textField : UITextField!) -> Void in
        //            textField.placeholder = "Enter First Name"
        //        }
        //alertController.addTextField { textFiled in }
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func fetchFilter(_ author: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "PostData", in: appDelegate!.persistentContainer.viewContext)
        
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entityDescription
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "authorCell == %@", author)
        request.predicate = predicate
        
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDelegate!.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController?.delegate = self
        
        do {
            try fetchResultController?.performFetch()
            
        } catch let error as NSError {
            print(error.userInfo)
        }
        tableView.reloadData()
        
        
    }
    
    @objc func cancelFilteredSearchAction() {
    }
    
    
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let person = CoreDataManager.shared.favoritePost[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completionHandler) in
            managedContext.delete(person as NSManagedObject)
            CoreDataManager.shared.favoritePost.remove(at: indexPath.row)
            
            do {
                try managedContext.save()
            } catch
                let error as NSError {
                print("Could not save. \(error),\(error.userInfo)")
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let swipeActionsConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionsConfig.performsFirstActionWithFullSwipe = true
        
        return swipeActionsConfig
    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //
    //        if editingStyle == UITableViewCell.EditingStyle.delete {
    //
    //            //let commit = favoritePost[indexPath.row]
    //
    //            let appDelegate = UIApplication.shared.delegate as? AppDelegate
    //
    //
    //            let managedContext = appDelegate!.persistentContainer.viewContext
    //            let person = CoreDataManager.shared.favoritePost[indexPath.row]
    //                if editingStyle == .delete {
    //                    managedContext.delete(person as NSManagedObject)
    //                    CoreDataManager.shared.favoritePost.remove(at: indexPath.row)
    //
    //
    //                    do {
    //                        try managedContext.save()
    //                    } catch
    //                    let error as NSError {
    //                        print("Could not save. \(error),\(error.userInfo)")
    //                    }
    //                    self.tableView.deleteRows(at: [indexPath], with: .fade)
    //                }
    //            }
    
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.favoritePost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        let post = CoreDataManager.shared.favoritePost[indexPath.row]
        cell.myCells(post)
        cell.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)
        return cell
    }
    
    
    
    
}


extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .update:
            tableView.reloadSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .automatic)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            }
        case .update:
            
            if let indexPath = indexPath {
                //let favoritePost = fetchResultController?.object(at: indexPath as IndexPath)
                let post = CoreDataManager.shared.favoritePost[indexPath.row]
                guard let cell = tableView.cellForRow(at: indexPath as IndexPath) as? FavoriteTableViewCell else { break }
                cell.myCells(post)
                
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .automatic)
            }
            
            
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
