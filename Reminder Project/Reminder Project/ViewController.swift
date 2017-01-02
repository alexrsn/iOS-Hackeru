//
//  ViewController.swift
//  Reminder Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import Contacts
import CoreData

class ViewController: UIViewController {
    
    var imgLogo: UIImageView!;
    var btnReminders: UIButton!;
    var btnImportBirthdays: UIButton!;
    var btnReportBug: UIButton!;
    
    var remindersTableViewController: RemindersTableViewController!;
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let image = UIImage(named: "reminder.png");
        imgLogo = UIImageView(image: image!);
        imgLogo.frame = CGRect(x: 0, y: 90, width: 100, height: 100);
        imgLogo.center.x = view.center.x;
        view.addSubview(imgLogo);
        
        btnReminders = UIButton(type: .system);
        btnReminders.frame = CGRect(x: 0, y: imgLogo.frame.maxY + 50, width: view.frame.width, height: 50);
        btnReminders.setTitle("To Do Reminders", for: .normal);
        btnReminders.addTarget(self, action: #selector(goToReminders), for: .touchUpInside);
        view.addSubview(btnReminders);
        
        btnImportBirthdays = UIButton(type: .system);
        btnImportBirthdays.frame = CGRect(x: 0, y: btnReminders.frame.maxY, width: view.frame.width, height: 50);
        btnImportBirthdays.setTitle("Import Contacts Birthdays", for: .normal);
        btnImportBirthdays.addTarget(self, action: #selector(importBirthdays), for: .touchUpInside);
        view.addSubview(btnImportBirthdays);
        
        btnReportBug = UIButton(type: .system);
        btnReportBug.frame = CGRect(x: 0, y: btnImportBirthdays.frame.maxY, width: view.frame.width, height: 50);
        btnReportBug.setTitle("Report Bug", for: .normal);
        btnReportBug.addTarget(self, action: #selector(reportBug), for: .touchUpInside);
        view.addSubview(btnReportBug);
    }
    
    func goToReminders(sender: UIButton){
        if(remindersTableViewController == nil){
            remindersTableViewController = RemindersTableViewController();
        }
        navigationController?.pushViewController(remindersTableViewController, animated: true);
    }
    
    func importBirthdays(sender: UIButton){
        let alertController = UIAlertController(title: "Import Birthdays", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert);
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
        let importAction = UIAlertAction(title: "Import", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            for contact in self.contacts{
                if(contact.birthday != nil){
                    var birthday = contact.birthday!;
                    birthday.hour = 10;
                    let reminder = Reminder(context: self.appDelegate.persistentContainer.viewContext);
                    reminder.title = "\(contact.givenName) \(contact.familyName) Birthday";
                    reminder.note = "Don't forget to wish a Happy Birthday!!!";
                    let trimmedPhoneNumber = contact.phoneNumbers.first!.value.stringValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "");
                    reminder.phoneNumber = trimmedPhoneNumber;
                    reminder.date = birthday.date as NSDate?;
                    reminder.rep = 1;
                }
                do{
                    try self.appDelegate.persistentContainer.viewContext.save();
                }catch{
                    print(error);
                }
            }
            self.goToReminders(sender: sender);
        }
        alertController.addAction(cancelAction);
        alertController.addAction(importAction);
        self.present(alertController, animated: true, completion: nil);
    }
    
    func reportBug(sender: UIButton){
        let email = "support@reminder.com";
        if let url = URL(string: "mailto:\(email)"){
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil);
            } else {
                UIApplication.shared.openURL(url);
            }
        }
    }
    
    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore();
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactBirthdayKey];
        var allContainers: [CNContainer] = [];
        do {
            allContainers = try contactStore.containers(matching: nil);
        } catch {
            print("Error fetching containers");
        }
        var results: [CNContact] = [];
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier);
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as [CNKeyDescriptor]);
                results.append(contentsOf: containerResults);
            } catch {
                print("Error fetching results for container");
            }
        }
        return results;
    }();
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
