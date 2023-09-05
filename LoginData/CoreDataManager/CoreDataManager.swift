//
//  CoreDataManager.swift
//  LoginData
//
//  Created by apple on 04/09/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let sharedInstance: CoreDataManager = CoreDataManager()
    private init() {
        
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "LoginData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveNewsDetails(articleData: ArticleData) {
        let context = persistentContainer.viewContext
        var login = NSEntityDescription.insertNewObject(forEntityName: "NewModel", into: context) as! NewModel
        login.title = articleData.title ?? ""
        login.descrip = articleData.description ?? ""
        login.author = articleData.author ?? ""
        login.publishedAt = articleData.publishedAt ?? ""
        login.content = articleData.content ?? ""
        login.urlToImage = articleData.urlToImage ?? ""
        do{
            try context.save()
        }catch{
            print("data is mot save")
        }
    }
    
    //MARK:-FetchData
       func getNewsData()-> [NewModel] {
           let context = persistentContainer.viewContext
           var login = [NewModel]()
           let fectchRequest = NSFetchRequest<NSManagedObject>(entityName: "NewModel")
           do{
               login = try context.fetch(fectchRequest) as! [NewModel]
   
           }
           catch{
               print("can not get data")
           }
           return login
       }
    
    func deleteAllData(entity: String) {
        let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
}
