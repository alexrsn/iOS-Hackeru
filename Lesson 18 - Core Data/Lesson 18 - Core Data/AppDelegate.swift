//
//  AppDelegate.swift
//  Lesson 18 - Core Data
//
//  Created by Alex on 11/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let entityName = "Person";
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //populateDatabase();		
        
        //updateDatabase();
        
        //deleteFromDatabase();
        
        populateDatabase();
        
        //updateDatabase();
        
        //readingFromTheDatabase();
        
        return true
    }
    
    func deleteFromDatabase(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        do{
            let persons = try managedObjectContext.fetch(fetchRequest) as! [Person];
            for p in persons{
                if Int(p.age) % 2 == 0 {
                    managedObjectContext.delete(p);
                }
            }
        }catch{
            print("error deleting");
        }
    }
    
    func readingFromTheDatabase() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName);
        //fetchRequest.fetchLimit = 10;
        //fetchRequest.fetchOffset = 100;
        let ageSort = NSSortDescriptor(key: "age", ascending: true);
        let firstNameSort = NSSortDescriptor(key: "firstName", ascending: true);
        fetchRequest.sortDescriptors = [ageSort, firstNameSort];
        //fetchRequest.predicate = NSPredicate(format: "age > %@", 50 );
        do{
            let persons = try managedObjectContext.fetch(fetchRequest) as! [Person];
            for p in persons {
                print("person \(p.firstName) \(p.lastName) \(p.age)");
            }
        }catch{
            print("failed to fatch");
        }
        
    }
    
    func updateDatabase(){
        
        let batch = NSBatchUpdateRequest(entityName: entityName);
        batch.propertiesToUpdate = ["age" : 18];
        batch.predicate = NSPredicate(format: "age < %@", 18 as NSNumber);
        batch.resultType = .updatedObjectsCountResultType;
        do{
            let result = try managedObjectContext.execute(batch);
            let theResult = result as! NSBatchUpdateResult;
            let numberOfRowsAffected = theResult.result as! Int;
            print("Number of rows affected: \(numberOfRowsAffected)");
        }catch{
            print("error while updating rows");
        }
        
    }
    
    func populateDatabase(){
        for counter in 0..<1000 {
            let person = NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext) as! Person;
            person.firstName = "First Name \(counter)";
            person.lastName = "Last Name \(counter)";
            person.age = NSNumber(value: arc4random_uniform(120) as UInt32);
        }
        do{
            try managedObjectContext.save();
            print("data was saved to db");
        }catch{
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.example.Lesson_18___Core_Data" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Lesson_18___Core_Data", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

