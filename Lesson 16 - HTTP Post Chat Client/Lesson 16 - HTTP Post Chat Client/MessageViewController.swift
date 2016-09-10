//
//  MessageViewController.swift
//  Lesson 16 - HTTP Post Chat Client
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit



class MessageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate , NSURLSessionDelegate{
    
    
    
    var lblTitle: UITextView!;
    var btnBack: UIButton!;
    var messagesTable: UITableView!;
    var txtMessageToSend: UITextField!;
    var btnSend: UIButton!;
    
    var session: NSURLSession!;
    var receivedData: NSData!;
    var messages: [String]!;
    let identifier = "identifier";
    var timer:NSTimer!;
    
    var recipient:String = "";
    var userName:String = "";
    var password:String = "";
    var isSending = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor();
        
        lblTitle = UITextView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 30));
        
        view.addSubview(lblTitle);
        
        btnBack = UIButton(type: .System);
        btnBack.frame = CGRect(x: view.frame.width - 50, y: 30, width: 50, height: 30);
        btnBack.setTitle("Back", forState: .Normal);
        btnBack.addTarget(self, action: "btnBack:", forControlEvents: .TouchUpInside);
        view.addSubview(btnBack);

        
        CGRect(x: 0, y: 65, width: view.frame.width, height: view.frame.height - 80)
        messagesTable = UITableView(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: view.frame.height - 110), style: .Plain);
        messagesTable.dataSource = self;
        messagesTable.delegate = self;
        view.addSubview(messagesTable);
        
        txtMessageToSend = UITextField(frame: CGRect(x: 0, y: messagesTable.frame.maxY + 5, width: 200, height: 30));
        txtMessageToSend.placeholder = "Message to send";
        view.addSubview(txtMessageToSend);
        
        btnSend = UIButton(type: .System);
        btnSend.frame = CGRect(x: 205, y: messagesTable.frame.maxY, width: 100, height: 30);
        btnSend.setTitle("Send", forState: .Normal);
        btnSend.addTarget(self, action: "btnSend:", forControlEvents: .TouchUpInside);
        view.addSubview(btnSend);
        
    }
    
    override func viewWillAppear(animated: Bool) {
        messages = [String]();
        getMessages();
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkForMessages:", userInfo: nil, repeats: true);
        lblTitle.text = recipient;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier);
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier);
            
        }
        cell?.textLabel?.text = messages[indexPath.row] as? String;
        return cell!;
    }
    
    func btnBack(sender: UIButton) {
        if timer != nil{
            timer.invalidate();
            timer = nil;
        }
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func btnSend(sender: UIButton) {
        isSending = true;
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "sendMessage",
                "userName" : "\(userName)",
                "password" : "\(password)",
                "recipient" : "\(self.recipient)",
                "text" : "\(self.txtMessageToSend.text!)"
                
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
    
    func checkForMessages(sender: NSTimer) {
        getMessages();
    }
    
    func getMessages(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "getMessages",
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
                    if !isSending{
                        let newMessages = jsonObject["messages"] as? NSArray;
                        if newMessages != nil {
                            for mes in newMessages! {
                                messages.append("\(mes["text"] as! String) (\(mes["sender"] as! String))");
                            }
                            dispatch_async(dispatch_get_main_queue(), {
                                self.messagesTable.reloadData();
                            })
                        }
                    }else{
                        isSending = false;
                        messages.append("\(self.txtMessageToSend.text!) (me)");
                    }
                    
                }else{
                    print("messages: failure")
                }
            }catch{
                
            }
            
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        receivedData = data;
    }
    
    deinit{
        if timer != nil{
            timer.invalidate();
            timer = nil;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}