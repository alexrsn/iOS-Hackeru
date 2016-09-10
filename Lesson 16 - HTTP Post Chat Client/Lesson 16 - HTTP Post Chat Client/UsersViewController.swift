//
//  UsersViewController.swift
//  Lesson 16 - HTTP Post Chat Client
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit



class UsersViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate{
    
    
    
    var usersTable: UITableView!;
    
    var session: NSURLSession!;
    var receivedData: NSData!;
    
    var userName:String = "";
    var password:String = "";
    
    var users: NSArray!;
    let identifier = "identifier";
    var timer: NSTimer!;
    var messageViewController:MessageViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor();
        
        users = NSArray();
        
        CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 30)
        usersTable = UITableView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 30), style: .Plain);
        view.addSubview(usersTable);
        
        usersTable.dataSource = self;
        usersTable.delegate = self;
        getUsers();
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "updateUsers:", userInfo: nil, repeats: true);
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(self.messageViewController == nil){
            self.messageViewController = MessageViewController();
            self.messageViewController!.userName = userName;
            self.messageViewController!.password = password;
        }
        self.messageViewController!.recipient = users[indexPath.row] as! String;
        self.presentViewController(self.messageViewController, animated: true, completion: nil);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier);
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier);
            
        }
        cell?.textLabel?.text = users[indexPath.row] as? String;
        return cell!;
    }
    
    func updateUsers(sender: NSTimer){
        getUsers();
    }
    
    func getUsers(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "getUsers",
                "userName" : "\(userName)",
                "password" : "\(password)"
        ]
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted);
            session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
            let url = NSURL(string: "http://146.148.28.47/SimpleChatHttpServer/ChatServlet");
            let request = NSMutableURLRequest(URL: url!);
            request.HTTPMethod = "POST";
            let task = session.uploadTaskWithRequest(request, fromData: jsonData);
            task.resume();
        }catch{
            
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error == nil{
            do{
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments) as! NSDictionary;
                let action = jsonObject["result"] as! String;
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
                if (action == "success"){
                    self.users = jsonObject["users"] as! NSArray;
                    dispatch_async(dispatch_get_main_queue(), {
                        self.usersTable.reloadData();
                        
                    })
                }else{
                    print("get users: failure")
                }
            }catch{
                
            }
            
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        receivedData = data;
    }
    
    deinit{
        timer.invalidate();
        timer = nil;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}