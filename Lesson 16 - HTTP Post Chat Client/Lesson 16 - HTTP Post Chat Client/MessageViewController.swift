//
//  MessageViewController.swift
//  Lesson 16 - HTTP Post Chat Client
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


class MessageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate , URLSessionDelegate{
    
    
    
    var lblTitle: UITextView!;
    var btnBack: UIButton!;
    var messagesTable: UITableView!;
    var txtMessageToSend: UITextField!;
    var btnSend: UIButton!;
    
    var session: Foundation.URLSession!;
    var receivedData: Data!;
    var messages: [String]!;
    let identifier = "identifier";
    var timer:Timer!;
    
    var recipient:String = "";
    var userName:String = "";
    var password:String = "";
    var isSending = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;
        
        lblTitle = UITextView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 30));
        
        view.addSubview(lblTitle);
        
        btnBack = UIButton(type: .system);
        btnBack.frame = CGRect(x: view.frame.width - 50, y: 30, width: 50, height: 30);
        btnBack.setTitle("Back", for: UIControlState());
        btnBack.addTarget(self, action: #selector(MessageViewController.btnBack(_:)), for: .touchUpInside);
        view.addSubview(btnBack);

        messagesTable = UITableView(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: view.frame.height - 110), style: .plain);
        messagesTable.dataSource = self;
        messagesTable.delegate = self;
        view.addSubview(messagesTable);
        
        txtMessageToSend = UITextField(frame: CGRect(x: 0, y: messagesTable.frame.maxY + 5, width: 200, height: 30));
        txtMessageToSend.placeholder = "Message to send";
        view.addSubview(txtMessageToSend);
        
        btnSend = UIButton(type: .system);
        btnSend.frame = CGRect(x: 205, y: messagesTable.frame.maxY, width: 100, height: 30);
        btnSend.setTitle("Send", for: UIControlState());
        btnSend.addTarget(self, action: #selector(MessageViewController.btnSend(_:)), for: .touchUpInside);
        view.addSubview(btnSend);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messages = [String]();
        getMessages();
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MessageViewController.checkForMessages(_:)), userInfo: nil, repeats: true);
        lblTitle.text = recipient;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier);
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier);
            
        }
        cell?.textLabel?.text = messages[(indexPath as NSIndexPath).row];
        return cell!;
    }
    
    func btnBack(_ sender: UIButton) {
        if timer != nil{
            timer.invalidate();
            timer = nil;
        }
        self.dismiss(animated: true, completion: nil);
    }
    
    func btnSend(_ sender: UIButton) {
        isSending = true;
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        let configuration = URLSessionConfiguration.default;
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "sendMessage" as AnyObject,
                "userName" : "\(userName)" as AnyObject,
                "password" : "\(password)" as AnyObject,
                "recipient" : "\(self.recipient)" as AnyObject,
                "text" : "\(self.txtMessageToSend.text!)" as AnyObject
                
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
    
    func checkForMessages(_ sender: Timer) {
        getMessages();
    }
    
    func getMessages(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        let configuration = URLSessionConfiguration.default;
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "getMessages" as AnyObject,
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
                    if !isSending{
                        let newMessages = jsonObject["messages"] as? [[String:Any]];
                        if newMessages != nil {
                            for mes in newMessages!{
                                messages.append("\(mes["text"] as! String) \(mes["sender"] as! String)");
                            }
                            DispatchQueue.main.async(execute: {
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
    
    func URLSession(_ session: Foundation.URLSession, dataTask: URLSessionDataTask, didReceiveData data: Data) {
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
