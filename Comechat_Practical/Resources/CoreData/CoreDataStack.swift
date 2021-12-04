//
//  CoreDataStack.swift
//  CoreData-Transformable
//
//  Created by Disha Shah on 02/12/21.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ArrayInCoreData")
        container.loadPersistentStores(completionHandler: {(storeDescription, err) in if let err = err {
            fatalError("Loading of store failed: \(err)")
        }})
        return container
    }()
    
    static func fetchProjects() -> [Newsfeed] {

        let fetchRequest = NSFetchRequest<Newsfeed>(entityName: "Newsfeed")
        fetchRequest.sortDescriptors = [NSSortDescriptor (key: "date", ascending: false)]
        let context = Constants.appDelegate.persistentContainer.viewContext
        do{
            let myProjects = try context.fetch(fetchRequest)
            return myProjects
        } catch let fetchErr{
            print("Failed to fetch companiess: ", fetchErr)
            return []
        }
    }
}
