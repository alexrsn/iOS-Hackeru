//
//  CoreDataManager.swift
//  Reminder iOS Project
//
//  Created by Alex on 28/11/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    
    
    static let instance = CoreDataManager()
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "Reminder_iOS_Project", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
//    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
//        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
//        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
//        var failureReason = "There was an error creating or loading the application's saved data."
//        do {
//            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
//        } catch {
//            var dict = [String: AnyObject]()
//            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
//            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
//            dict[NSUnderlyingErrorKey] = error as NSError
//            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
//            abort()
//        }
//        return coordinator
//    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        return appDelegate.persistentContainer.viewContext;
    }
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: getContext())!;
    }
    
    func fetchedResultsController(entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true);
        fetchRequest.sortDescriptors = [sortDescriptor];
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: getContext(), sectionNameKeyPath: nil, cacheName: nil);
        return fetchedResultsController;
    }
}
