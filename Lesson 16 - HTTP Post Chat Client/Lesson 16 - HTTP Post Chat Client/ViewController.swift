//
//  ViewController.swift
//  Lesson 16 - HTTP Post Chat Client
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate{

    var txtUserName: UITextField!;
    var txtPassword: UITextField!;
    var btnLogin: UIButton!;
    var btnSignUp: UIButton!;
    var lblMessage: UITextView!;
    
    var session: Foundation.URLSession!;
    var receivedData: Data!;
    var usersViewController: UsersViewController!;    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUserName = UITextField(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 30));
        txtUserName.placeholder = "username";
        txtUserName.text = "Alex";
        txtUserName.borderStyle = .roundedRect
        view.addSubview(txtUserName);
        
        txtPassword = UITextField(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: 30));
        txtPassword.placeholder = "password";
        txtPassword.text = "1234";
        txtPassword.isSecureTextEntry = true;
        txtPassword.borderStyle = .roundedRect
        view.addSubview(txtPassword);
        
        btnSignUp = UIButton(type: .system);
        btnSignUp.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 30);
        btnSignUp.setTitle("Sign Up", for: UIControlState());
        btnSignUp.addTarget(self, action: #selector(ViewController.btnSignUp(_:)), for: .touchUpInside);
        view.addSubview(btnSignUp);
        
        btnLogin = UIButton(type: .system);
        btnLogin.frame = CGRect(x: 0, y: 135, width: view.frame.width, height: 30);
        btnLogin.setTitle("Login", for: UIControlState());
        btnLogin.addTarget(self, action: #selector(ViewController.btnLogin(_:)), for: .touchUpInside);
        view.addSubview(btnLogin);
        
        lblMessage = UITextView(frame: CGRect(x: 0, y: 170, width: view.frame.width, height: 30));
        view.addSubview(lblMessage);
        
    }
    
    func btnSignUp(_ sender: UIButton){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        self.btnLogin.isEnabled = false;
        self.btnSignUp.isEnabled = false;
        let configuration = URLSessionConfiguration.default;
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "signup" as AnyObject,
                "userName" : "\(txtUserName.text)" as AnyObject,
                "password" : "\(txtPassword.text)" as AnyObject,
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

    func btnLogin(_ sender: UIButton){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        self.btnLogin.isEnabled = false;
        self.btnSignUp.isEnabled = false;
        let configuration = URLSessionConfiguration.default;
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "action" : "login" as AnyObject,
                "userName" : "\(txtUserName.text)" as AnyObject,
                "password" : "\(txtPassword.text)" as AnyObject,
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
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                    self.btnLogin.isEnabled = true;
                    self.btnSignUp.isEnabled = true;
                    if (action == "success"){
                        if(self.usersViewController == nil){
                            self.usersViewController = UsersViewController();
                            self.usersViewController!.userName = self.txtUserName.text!;
                            self.usersViewController!.password = self.txtPassword.text!;
                        }
                        self.present(self.usersViewController, animated: true, completion: nil);
                    }else{
                        self.lblMessage.text = "Failure";
                    }
                })
            }catch{
                
            }
            
        }
    }
    
    func URLSession(_ session: Foundation.URLSession, dataTask: URLSessionDataTask, didReceiveData data: Data) {
        receivedData = data;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

