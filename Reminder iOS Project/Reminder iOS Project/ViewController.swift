//
//  ViewController.swift
//  Reminder iOS Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var btnReminders: UIButton!;
    var btnSettings: UIButton!;
    var btnReportBug: UIButton!;
    var btnExit: UIButton!;
    
    var remindersViewController: RemindersViewController!;
    var settingsViewController: SettingsViewController!;

    
    //var navigationController: UINavigationController;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnReminders = UIButton(type: .system);
        btnReminders.frame = CGRect(x: 0, y: view.center.y - 100, width: view.frame.width, height: 50);
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
        if(remindersViewController == nil){
            remindersViewController = RemindersViewController();
        }
        present(remindersViewController, animated: true, completion: nil);
    }
    
    func goToSettings(sender: UIButton){
        if(settingsViewController == nil){
            settingsViewController = SettingsViewController();
        }
        present(settingsViewController, animated: true, completion: nil);
    }
    
    func reportBug(sender: UIButton){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

