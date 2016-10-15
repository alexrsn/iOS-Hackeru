//
//  UsersViewController.swift
//  Lesson 16 - HTTP Post Chat Client
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit



class UsersViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, URLSessionDelegate{
    
    
    
    var usersTable: UITableView!;
    
    var session: Foundation.URLSession!;
    var receivedData: Data!;
    
    var userName:String = "";
    var password:String = "";
    
    var users: NSArray!;
    let identifier = "identifier";
    var timer: Timer!;
    var messageViewController:MessageViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        
        users = NSArray();
        
        usersTable = UITableView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 30), style: .plain);
        view.addSubview(usersTable);
        
        usersTable.dataSource = self;
        usersTable.delegate = self;
        getUsers();
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(UsersViewController.updateUsers(_:)), userInfo: nil, repeats: true);
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.messageViewController == nil){
            self.messageViewController = MessageViewController();
            self.messageViewController!.userName = userName;
            self.messageViewController!.password = password;
        }
        self.messageViewController!.recipient = users[(indexPath as NSIndexPath).row] as! String;
        self.present(self.messageViewController, animated: true, completion: nil);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier);
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier);
            
        }
        cell?.textLabel?.text = users[(indexPath as NSIndexPath).row] as? String;
        return cell!;
    }
    
    func updateUsers(_ sender: Timer){
        getUsers();
    }
    
    func getUsers(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        let configuration = URLSessionConfiguration.default;
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "getUsers" as AnyObject,
                "userName" : "\(userName)" as AnyObject,
                "password" : "\(password)" as AnyObject
        ]
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted);
            session = Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: nil);
            let url = URL(string: "http://146.148.28.47/SimpleChatHttpServer/ChatServlet");
            let request = NSMutableURLRequest(url: url!);
            request.httpMethod = "POST";
            let task = session.uploadTask(with: request as URLRequest, from: jsonData);
            task.resume();
        }catch{
            
        }
    }
    
    func URLSession(_ session: Foundation.URLSession, task: URLSessionTask, didCompleteWithError error: NSError?) {
        if error == nil{
            do{
                let jsonObject = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments) as! NSDictionary;
                let action = jsonObject["result"] as! String;
                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                if (action == "success"){
                    self.users = jsonObject["users"] as! NSArray;
                    DispatchQueue.main.async(execute: {
                        self.usersTable.reloadData();
                        
                    })
                }else{
                    print("get users: failure")
                }
            }catch{
                
            }
            
        }
    }
    
    func URLSession(_ session: Foundation.URLSession, dataTask: URLSessionDataTask, didReceiveData data: Data) {
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
