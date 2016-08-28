//
//  ViewController.swift
//  Lesson 11 - TableView with Refresh
//
//  Created by Alex on 18/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!;
    var data:[NSDate] = [NSDate]();
    var refreshControl: UIRefreshControl!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.append(NSDate());
        
        tableView = UITableView(frame: view.frame, style: .Plain);
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier");
        tableView.dataSource = self;
        tableView.delegate = self;
        view.addSubview(tableView);
        
        refreshControl = UIRefreshControl();
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: .ValueChanged);
        
        tableView.addSubview(refreshControl);
        
        
        
    }
    
    func handleRefresh(sender: UIRefreshControl){
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)*5);
        dispatch_after(popTime, dispatch_get_main_queue()) { [weak self]()->Void in
            self!.data.append(NSDate());
            self!.refreshControl.endRefreshing();
            let indexPathOfNewRow = NSIndexPath(forRow: self!.data.count - 1, inSection: 0);
            self!.tableView.insertRowsAtIndexPaths([indexPathOfNewRow], withRowAnimation: .Automatic);
        }
        
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath);
        cell.textLabel?.text = "\(data[indexPath.row])";
        return cell;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}