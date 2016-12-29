//
//  RemindersViewController.swift
//  Reminder Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

class RemindersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate;

    var addNewReminder: UIBarButtonItem!;
    
    let identifier = "ReminderCell";
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white;
        addNewReminder = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target:self, action: #selector(addReminder));
        navigationItem.title = "Reminders";
        navigationItem.rightBarButtonItem = addNewReminder;
        appDelegate.fetchedResultsController.delegate = self;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.register(ReminderTableViewCell.classForCoder(), forCellReuseIdentifier: identifier);
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reminders = self.appDelegate.fetchedResultsController.fetchedObjects else { return 0 };
        return reminders.count;
    }
    
    func addReminder(sender: UIBarButtonItem) {
        let reminderViewController = ReminderViewController();
        reminderViewController.managedObjectContext = self.appDelegate.persistentContainer.viewContext;
        navigationController?.pushViewController(reminderViewController, animated: true);
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ReminderTableViewCell else {
            fatalError("Unexpected Index Path");
        }
        configure(cell, at: indexPath);
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do{
                let reminder = self.appDelegate.fetchedResultsController.object(at: indexPath);
                reminder.managedObjectContext?.delete(reminder);
                try self.appDelegate.persistentContainer.viewContext.save();
                appDelegate.setNotifications();
            }catch{
                print(error);
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminderViewController = ReminderViewController();
        reminderViewController.managedObjectContext = self.appDelegate.persistentContainer.viewContext;
        reminderViewController.reminder = self.appDelegate.fetchedResultsController.object(at: indexPath);
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
                configure(cell, at: indexPath);
            }
            break;
        }
    }
    
    func configure(_ cell: ReminderTableViewCell, at indexPath: IndexPath) {
        let reminder = self.appDelegate.fetchedResultsController.object(at: indexPath);
        cell.lblTitle.text = "Title: \(reminder.title!)";
        cell.lblNote.text = "Note: \(reminder.note!)";
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
}
