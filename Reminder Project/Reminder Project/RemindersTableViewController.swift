//
//  RemindersViewController.swift
//  Reminder iOS Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import UserNotificationsUI //framework to customize the notification

class RemindersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //var remindersTable: UITableView!;
    var addNewReminder: UIBarButtonItem!;
    
    let identifier = "ReminderCell";
    let notificationIdentifier = "ReminderNotification"; //identifier is to cancel the notification request
    
    
    private let persistentContainer = NSPersistentContainer(name: "Reminder_Project");
    
    lazy var fetchedResultsController: NSFetchedResultsController<Reminder> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest();
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController;
    }();
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white;
        addNewReminder = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target:self, action: #selector(addReminder));
        navigationItem.title = "Reminders";
        navigationItem.rightBarButtonItem = addNewReminder;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.register(ReminderTableViewCell.classForCoder(), forCellReuseIdentifier: identifier);
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            }else{
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reminders = fetchedResultsController.fetchedObjects else { return 0 }
        return reminders.count
    }
    
    func addReminder(sender: UIBarButtonItem) {
        let reminderViewController = ReminderViewController();
        reminderViewController.managedObjectContext = persistentContainer.viewContext;
        navigationController?.pushViewController(reminderViewController, animated: true);
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ReminderTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        configure(cell, at: indexPath)
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do{
                let reminder = fetchedResultsController.object(at: indexPath);
                reminder.managedObjectContext?.delete(reminder);
                try persistentContainer.viewContext.save();
            }catch{
                print(error);
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminderViewController = ReminderViewController();
        reminderViewController.managedObjectContext = persistentContainer.viewContext;
        reminderViewController.reminder = fetchedResultsController.object(at: indexPath);
        navigationController?.pushViewController(reminderViewController, animated: true);
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates();
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates();
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if indexPath == nil {
                tableView.insertRows(at: [newIndexPath!], with: .fade);
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade);
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade);
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade);
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? ReminderTableViewCell {
                configure(cell, at: indexPath)
            }
            break;
        }
        stopAllNotifications();
        setAllNotifications();
    }
    
    func configure(_ cell: ReminderTableViewCell, at indexPath: IndexPath) {
        // Fetch Quote
        let reminder = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.lblTitle.text = "Title: \(reminder.title!)";
        cell.lblTitle.sizeToFit();
        cell.lblNote.text = "Note: \(reminder.note!)";
        cell.lblNote.sizeToFit();
        let dateOriginal:NSDate = reminder.date!;
        let calendar = Calendar(identifier: .gregorian);
        let dateComp:DateComponents = calendar.dateComponents(in: .current, from: dateOriginal as Date);
        var hour:String;
        var minute:String;
        if dateComp.hour! < 10 {
            hour = "0\(dateComp.hour!)";
        }else{
            hour = "\(dateComp.hour!)";
        }
        if dateComp.minute! < 10 {
            minute = "0\(dateComp.minute!)";
        }else{
            minute = "\(dateComp.minute!)";
        }
        let dateStr = "\(dateComp.day!)/\(dateComp.month!)/\(dateComp.year!)  \(hour):\(minute)";
        cell.lblDate.text = "\(dateStr)";
        cell.lblDate.sizeToFit();
        cell.lblRepeat.text = "\(reminderRepeatStrings[Int(reminder.rep)])";
        cell.lblRepeat.sizeToFit();
        if (reminder.phoneNumber?.isEmpty)! {
            cell.callButton.isHidden = true;
        }else{
            cell.callButton.isHidden = false;
            cell.phoneNum = reminder.phoneNumber;
        }
    }
    
    func setNotification(reminder: Reminder){
        let interval = reminder.date!.timeIntervalSince(Date());
        if interval <= 0 {
            return;
        }
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.subtitle = reminder.title!;
        content.body = reminder.note!;
        content.sound = UNNotificationSound.default();
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: interval, repeats: false);
        let request = UNNotificationRequest(identifier:notificationIdentifier, content: content, trigger: trigger);
        UNUserNotificationCenter.current().delegate = self;
        UNUserNotificationCenter.current().add(request){(error) in
            if (error != nil){
                print(error!);
            }
        }
    }
    
    func setAllNotifications() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminder")
        
        do{
            let reminders = try persistentContainer.viewContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for reminder in reminders {
                setNotification(reminder: reminder as! Reminder);
            }
        }catch{
            print(error);
        }
    }
    
    func stopAllNotifications() {
        print("Removed all pending notifications");
        let center = UNUserNotificationCenter.current();
        center.removePendingNotificationRequests(withIdentifiers: [notificationIdentifier]);
    }
}

extension RemindersTableViewController:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == notificationIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}
