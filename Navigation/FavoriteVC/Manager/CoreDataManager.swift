//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Shom on 25.07.2022.
//

import Foundation
import UIKit
import CoreData
import StorageService

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    public var favoritePost = [PostData]()
    
//    var fetchResult: NSFetchedResultsController<PostData> {
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        let fetchRequest: NSFetchRequest<PostData> = PostData.fetchRequest()
//        
//        let sortDescriptor = NSSortDescriptor(key: "authorCell", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate!.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: "Master")
//        
//        do {
//            try fetchResultController.performFetch()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        
//        return fetchResultController
//    }
    
    
    //сохранение поста
    public func saveToCoreData(post: Post) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "PostData", in: context) else { return }
            
            //сохранение данных в фоновом потоке
            appDelegate.persistentContainer.performBackgroundTask { context in
                
                let newValue = NSManagedObject(entity: entityDescription, insertInto: context)

                let image = UIImage(named: post.image)
                let imageData = image?.pngData()
                
                newValue.setValue(imageData, forKey: "imageCell")
                newValue.setValue(post.author, forKey: "authorCell")
                newValue.setValue(post.description, forKey: "descriptionCell")
                newValue.setValue(post.likes, forKey: "likesCell")
                newValue.setValue(post.views, forKey: "viewsCell")
                newValue.setValue(post.id, forKey: "id")
                do {
                    try context.save()
                    print("\(post.author) saved")
                } catch {
                    print("error saving")
                }
            }
         
        }
    }
    
    //извлечение данных
    public func outFromCoreData() {
        favoritePost.removeAll()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<PostData>(entityName: "PostData")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    favoritePost.append(result)
                }
            } catch {
                print("error out from CoreData")
            }
        }
    }
    
    //метод удаления
    public func removeFromCoreData() {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchReauest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PostData")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReauest)
            
            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
  
}

////Ссылка на AppDelegate
//let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
////Создаем контекст
//let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
////Описание сущности
//let entityDescription = NSEntityDescription.entity(forEntityName: "PostData", in: context)
//
////Создание объекта
//let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
//
////установка значений атрибутов
////managedObject.setValue("Vasya", forKey: "authorCell")
////managedObject.setValue("Films", forKey: "descriptionCell")
//
////Извлекаем значение атрибута
////let author = managedObject.value(forKey: "authorCell")
////let description = managedObject.value(forKey:)
////print(author)
//
////Сохранение данных в стор
////appDelegate.saveContext()
//
////Извлекаем данные из стор
//let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostData")
//do {
//    let results = try context.fetch(fetchRequest)
//    for result in results as! [NSManagedObject] {
//        print(result.value(forKey: "authorCell"))
//    }
//} catch {
//    print(error)
//}
//
////Удалить все данные из стор
//do {
//    let results = try context.fetch(fetchRequest)
//    for result in results as! [NSManagedObject] {
//        context.delete(result)
//    }
//} catch {
//print(error)
//}
//
////Сохраняем удаленный контекст
//appDelegate.saveContext()
