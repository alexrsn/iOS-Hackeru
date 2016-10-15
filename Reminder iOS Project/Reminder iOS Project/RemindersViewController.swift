//
//  ViewController.swift
//  Reminder iOS Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var remindersTable: UITableView!;
    var data:[NSDate] = [NSDate]();
    var refreshControl: UIRefreshControl!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white;
        
        remindersTable = UITableView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 30), style: .plain);
        remindersTable.allowsMultipleSelection = false;
        remindersTable.register(ReminderTableViewCell.classForCoder(), forCellReuseIdentifier: "reminders");
        remindersTable.dataSource = self;
        //remindersTable.delegate = self;
        remindersTable.rowHeight = UITableViewAutomaticDimension;
        remindersTable.estimatedRowHeight = 100;
        
        view.addSubview(remindersTable);
        
        refreshControl = UIRefreshControl();
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged);
        
        remindersTable.addSubview(refreshControl);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.remindersTable.reloadData();
        
    }
    
    
    func handleRefresh(sender: UIRefreshControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.data.append(NSDate());
            self.refreshControl.endRefreshing();
            let indexPathOfNewRow = IndexPath(row: self.data.count - 1, section: 0);
            self.remindersTable.insertRows(at: [indexPathOfNewRow], with: .automatic);
            self.remindersTable.reloadData();
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminders", for: indexPath) as! ReminderTableViewCell;
        cell.lblTitle.text = "Title: \(data[indexPath.row])";
        //cell.textLabel?.text = "\(data[indexPath.row])";
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            data.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .left);
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

