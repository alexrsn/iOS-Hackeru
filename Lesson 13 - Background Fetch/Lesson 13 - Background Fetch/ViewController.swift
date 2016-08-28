//
//  ViewController.swift
//  Lesson 13 - Background Fetch
//
//  Created by Alex on 24/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    var mustReloadData = false;
    weak var appDelegate: AppDelegate!;
    var tableView: UITableView!;
    var isInBackground: Bool = false;
    let identifier = "identifier";
    
    
    var newsItems: [NewsItem]{
        return appDelegate.newsItems;
    }
    
    
    func hasNewNewsItem(){
        if isInBackground {
            mustReloadData = true;
        }else{
            tableView.reloadData();
        }
    }
    
    func didEnterBackground(){
        isInBackground = true;
    }
    
    func willEnterForeground(){
        isInBackground = false;
        if mustReloadData {
            tableView.reloadData();
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this allows us to get a pointer to the instance of AppDelegate created by the system.
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.viewController = self;
        tableView = UITableView(frame: view.frame, style: .Plain);
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier");
        tableView.dataSource = self;
        view.addSubview(tableView);
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier,forIndexPath: indexPath);
        cell.textLabel?.text = newsItems[indexPath.row].text;
        return cell;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}














