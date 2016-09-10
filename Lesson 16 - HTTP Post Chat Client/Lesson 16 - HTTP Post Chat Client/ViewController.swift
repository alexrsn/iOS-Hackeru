//
//  ViewController.swift
//  Lesson 16 - HTTP Post Chat Client
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLSessionDelegate{

    var txtUserName: UITextField!;
    var txtPassword: UITextField!;
    var btnLogin: UIButton!;
    var btnSignUp: UIButton!;
    var lblMessage: UITextView!;
    
    var session: NSURLSession!;
    var receivedData: NSData!;
    var usersViewController: UsersViewController!;    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUserName = UITextField(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 30));
        txtUserName.placeholder = "username";
        txtUserName.text = "Alex";
        txtUserName.borderStyle = .RoundedRect
        view.addSubview(txtUserName);
        
        txtPassword = UITextField(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: 30));
        txtPassword.placeholder = "password";
        txtPassword.text = "1234";
        txtPassword.secureTextEntry = true;
        txtPassword.borderStyle = .RoundedRect
        view.addSubview(txtPassword);
        
        btnSignUp = UIButton(type: .System);
        btnSignUp.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 30);
        btnSignUp.setTitle("Sign Up", forState: .Normal);
        btnSignUp.addTarget(self, action: "btnSignUp:", forControlEvents: .TouchUpInside);
        view.addSubview(btnSignUp);
        
        btnLogin = UIButton(type: .System);
        btnLogin.frame = CGRect(x: 0, y: 135, width: view.frame.width, height: 30);
        btnLogin.setTitle("Login", forState: .Normal);
        btnLogin.addTarget(self, action: "btnLogin:", forControlEvents: .TouchUpInside);
        view.addSubview(btnLogin);
        
        lblMessage = UITextView(frame: CGRect(x: 0, y: 170, width: view.frame.width, height: 30));
        view.addSubview(lblMessage);
        
    }
    
    func btnSignUp(sender: UIButton){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        self.btnLogin.enabled = false;
        self.btnSignUp.enabled = false;
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "signup",
                "userName" : "\(txtUserName.text)",
                "password" : "\(txtPassword.text)",
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

    func btnLogin(sender: UIButton){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        self.btnLogin.enabled = false;
        self.btnSignUp.enabled = false;
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "login",
                "userName" : "\(txtUserName.text)",
                "password" : "\(txtPassword.text)",
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
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
                    self.btnLogin.enabled = true;
                    self.btnSignUp.enabled = true;
                    if (action == "success"){
                        if(self.usersViewController == nil){
                            self.usersViewController = UsersViewController();
                            self.usersViewController!.userName = self.txtUserName.text!;
                            self.usersViewController!.password = self.txtPassword.text!;
                        }
                        self.presentViewController(self.usersViewController, animated: true, completion: nil);
                    }else{
                        self.lblMessage.text = "Failure";
                    }
                })
            }catch{
                
            }
            
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        receivedData = data;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

