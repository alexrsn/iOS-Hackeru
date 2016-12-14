//
//  ViewController.swift
//  Reminder iOS Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imgLogo: UIImageView!;
    var btnReminders: UIButton!;
    var btnSettings: UIButton!;
    var btnReportBug: UIButton!;
    var btnExit: UIButton!;
    
    var remindersTableViewController: RemindersTableViewController!;
    var settingsViewController: SettingsViewController!;
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        btnSettings = UIButton(type: .system);
        btnSettings.frame = CGRect(x: 0, y: btnReminders.frame.maxY, width: view.frame.width, height: 50);
        btnSettings.setTitle("Settings", for: .normal);
        btnSettings.addTarget(self, action: #selector(goToSettings), for: .touchUpInside);
        view.addSubview(btnSettings);
        
        btnReportBug = UIButton(type: .system);
        btnReportBug.frame = CGRect(x: 0, y: btnSettings.frame.maxY, width: view.frame.width, height: 50);
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
    
    func goToSettings(sender: UIButton){
        if(settingsViewController == nil){
            settingsViewController = SettingsViewController();
        }
        navigationController?.pushViewController(settingsViewController, animated: true);
    }
    
    func reportBug(sender: UIButton){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

