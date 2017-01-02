//
//  AppDelegate.swift
//  Reminder Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?;
    var isNotificationAllowed = false;
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current();
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted{
                self.isNotificationAllowed = true;
            }else{
                self.isNotificationAllowed = false;
            }
        };
        center.delegate = self;
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store");
                print("\(error), \(error.localizedDescription)");
            }else{
                do {
                    try self.fetchedResultsController.performFetch();
                } catch {
                    let fetchError = error as NSError;
                    print("Unable to Perform Fetch Request");
                    print("\(fetchError), \(fetchError.localizedDescription)");
                }
            }
        }
        return true;
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext();
    }
    
    // MARK: - Notifications
    
    func setNotification(reminder: Reminder){
        let content = UNMutableNotificationContent();
        content.title = reminder.title!;
        if reminder.note!.isEmpty{
            content.body = " ";
        }else{
            content.body = reminder.note!;
        }
        content.sound = UNNotificationSound.default();
        var trigger: UNCalendarNotificationTrigger;
        switch reminder.rep {
        case 1://Yearly
            let triggerYearly = Calendar.current.dateComponents([.month,.day,.hour,.minute], from: reminder.date! as Date);
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerYearly, repeats: true);
        case 2://Monthly
            let triggerMonthly = Calendar.current.dateComponents([.day,.hour,.minute], from: reminder.date! as Date);
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerMonthly, repeats: true);
        case 3://Weekly
            let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute], from: reminder.date! as Date);
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true);
        case 4://Daily
            let triggerDaily = Calendar.current.dateComponents([.hour,.minute], from: reminder.date! as Date);
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true);
        case 5://Hourly
            let triggerHourly = Calendar.current.dateComponents([.minute], from: reminder.date! as Date);
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerHourly, repeats: true);
        default:
            let interval = reminder.date!.timeIntervalSinceNow;
            if interval <= 0 {
                return;
            }
            let triggerOnce = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: reminder.date! as Date);
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerOnce, repeats: false);
        }
        let request = UNNotificationRequest(identifier:"\(reminder.title!)\(reminder.date)", content: content, trigger: trigger);
        UNUserNotificationCenter.current().add(request){(error) in
            if (error != nil){
                print(error!);
            }
        }
    }
    
    func setNotifications() {
        if isNotificationAllowed{
            let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest();
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)];
            do{
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests();
                let reminders = try persistentContainer.viewContext.fetch(fetchRequest);
                for reminder in reminders {
                    if (reminder.value(forKey: "date") as! NSDate).timeIntervalSinceNow >= 0{
                        setNotification(reminder: reminder);
                    }
                }
            }catch{
                print(error);
            }
        }else{
            print("Notifications not alowed!!!");
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Tapped in notification");
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification triggered");
        completionHandler( [.alert,.sound,.badge]);
    }
    
    // MARK: - Core Data
    
    let persistentContainer = NSPersistentContainer(name: "Reminder_Project");
    
    lazy var fetchedResultsController: NSFetchedResultsController<Reminder> = {
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest();
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)];
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil);
        return fetchedResultsController;
    }();
    
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
    
}

