//
//  RemindersViewController.swift
//  Reminder iOS Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

class RemindersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //var remindersTable: UITableView!;
    var addNewReminder: UIBarButtonItem!;
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Reminder", keyForSort: "date")
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white;
        addNewReminder = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target:self, action: #selector(addReminder));
        navigationItem.title = "Reminders";
        navigationItem.rightBarButtonItem = addNewReminder;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        fetchedResultsController.delegate = self;
        do{
            try fetchedResultsController.performFetch();
        }catch{
            print(error);
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects;
        } else {
            return 0;
        }
    }
    
    func addReminder(sender: UIBarButtonItem) {
        let reminderViewController = ReminderViewController();
        reminderViewController.reminder = Reminder();
        navigationController?.pushViewController(reminderViewController, animated: true);
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = fetchedResultsController.object(at: indexPath) as! Reminder;
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminders", for: indexPath) as! ReminderTableViewCell;
        cell.lblTitle.text = "Title: \(reminder.getTitle())";
        cell.lblTitle.sizeToFit();
        cell.lblNote.text = "Note: \(reminder.getNote())";
        cell.lblNote.sizeToFit();
        let dateOriginal:Date = reminder.getDate();
        let calendar = Calendar(identifier: .gregorian);
        let dateComp:DateComponents = calendar.dateComponents(in: .current, from: dateOriginal);
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
        cell.lblRepeat.text = "\(reminder.reminderRepeatStrings[reminder.getRepeat()])";
        cell.lblRepeat.sizeToFit();
        cell.phoneNum = reminder.getPhoneNumber();
        return cell;
    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 65;
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject;
            CoreDataManager.instance.managedObjectContext.delete(managedObject);
            CoreDataManager.instance.saveContext();
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminder = fetchedResultsController.object(at: indexPath) as! Reminder;
        let reminderViewController = ReminderViewController();
        reminderViewController.reminder = reminder;
        navigationController?.pushViewController(reminderViewController, animated: true);
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates();
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates();
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade);
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
            if let indexPath = indexPath {
                let reminder = fetchedResultsController.object(at: indexPath) as! Reminder;
                let cell = tableView.cellForRow(at: indexPath) as! ReminderTableViewCell;
                cell.lblTitle.text = "Title: \(reminder.getTitle())";
                cell.lblNote.text = "Note: \(reminder.getNote())";
                let dateOriginal:Date = reminder.getDate();
                let calendar = Calendar(identifier: .gregorian);
                let dateComp:DateComponents = calendar.dateComponents(in: .current, from: dateOriginal);
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
                cell.lblRepeat.text = "\(reminder.reminderRepeatStrings[reminder.getRepeat()])";
                cell.phoneNum = reminder.getPhoneNumber();
            }
        }
    }
}

//class RemindersTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var remindersTable: UITableView!;
//    var refreshControl: UIRefreshControl!;
//    var addNewReminder: UIBarButtonItem!;
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = UIColor.white;
//        addNewReminder = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target:self, action: #selector(addReminder));
//        navigationItem.title = "Reminders";
//        navigationItem.rightBarButtonItem = addNewReminder;
//
//        remindersTable = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain);
//        remindersTable.allowsMultipleSelection = false;
//        remindersTable.register(ReminderTableViewCell.classForCoder(), forCellReuseIdentifier: "reminders");
//        remindersTable.dataSource = self;
//        remindersTable.delegate = self;
//        view.addSubview(remindersTable);
//
//        refreshControl = UIRefreshControl();
//        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged);
//        remindersTable.addSubview(refreshControl);
//
////        let testReminder:ReminderItem = ReminderItem(title: "asda", note: "aasfsdg", date: Date(), phoneNumber: "2342325", rep: 3);
////        remindersData.append(testReminder);
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated);
//        self.remindersTable.reloadData();
//    }
//
//    func handleRefresh(sender: UIRefreshControl){
//        self.remindersTable.reloadData();
//        self.refreshControl.endRefreshing();
//    }
//
//    func addReminder(sender: UIBarButtonItem) {
//        let reminderViewController = ReminderViewController();
//        reminderViewController.reminderToEdit = -1;
//        navigationController?.pushViewController(reminderViewController, animated: true);
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return remindersData.count;
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reminders", for: indexPath) as! ReminderTableViewCell;
//        cell.lblTitle.text = "Title: \(remindersData[indexPath.row].getTitle())";
//        cell.lblTitle.sizeToFit();
//        cell.lblNote.text = "Note: \(remindersData[indexPath.row].getNote())";
//        cell.lblNote.sizeToFit();
//        let dateOriginal:Date = remindersData[indexPath.row].getDate();
//        let calendar = Calendar(identifier: .gregorian);
//        let dateComp:DateComponents = calendar.dateComponents(in: .current, from: dateOriginal);
//        var hour:String;
//        var minute:String;
//        if dateComp.hour! < 10 {
//            hour = "0\(dateComp.hour!)";
//        }else{
//            hour = "\(dateComp.hour!)";
//        }
//        if dateComp.minute! < 10 {
//            minute = "0\(dateComp.minute!)";
//        }else{
//            minute = "\(dateComp.minute!)";
//        }
//        let dateStr = "\(dateComp.day!)/\(dateComp.month!)/\(dateComp.year!)  \(hour):\(minute)";
//        cell.lblDate.text = "\(dateStr)";
//        cell.lblDate.sizeToFit();
//        cell.lblRepeat.text = "\(remindersData[indexPath.row].reminderRepeatStrings[remindersData[indexPath.row].getRepeat()])";
//        cell.lblRepeat.sizeToFit();
//        cell.phoneNum = remindersData[indexPath.row].getPhoneNumber();
//        return cell;
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            remindersData.remove(at: indexPath.row);
//            tableView.deleteRows(at: [indexPath], with: .left);
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 65;
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let reminderViewController = ReminderViewController();
//        navigationController?.pushViewController(reminderViewController, animated: true);
//        reminderViewController.reminderToEdit = indexPath.row;
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
//
