//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Shom on 25.07.2022.
//

import Foundation
import UIKit

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
