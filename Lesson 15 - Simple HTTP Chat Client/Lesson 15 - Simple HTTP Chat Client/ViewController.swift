//
//  ViewController.swift
//  Lesson 15 - Simple HTTP Chat Client
//
//  Created by Alex on 31/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NSURLSessionDataDelegate {
    
    var session: NSURLSession!;
    var label:UILabel!;
    var txtMessage:UITextField!;
    var button:UIButton!;
    var timer:NSTimer!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 30));
        label.center.x = view.center.x;
        view.addSubview(label);
        
        txtMessage = UITextField(frame: CGRect(x: 0, y: 65, width: view.frame.width, height: 30));
        txtMessage.borderStyle = .RoundedRect;
        view.addSubview(txtMessage);
        
        button = UIButton(type: .System);
        button.frame = CGRect(x: 0, y: 95, width: view.frame.width, height: 30);
        button.setTitle("Send", forState: .Normal);
        button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside);
        view.addSubview(button);
    }
    
    override func viewWillAppear(animated: Bool) {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "startCheckingForMessages:", userInfo: nil, repeats: true);
    }
    
    override func viewWillDisappear(animated: Bool) {
        if timer != nil{
            timer.invalidate();
            timer = nil;
        }
        if(session != nil){
            session.finishTasksAndInvalidate();
        }
    }
    
    func buttonClicked(sender: UIButton){
        let url = NSURL(string: "http://146.148.28.47/SimpleChatHttpServer/ChatServlet?\(self.txtMessage.text!)");
        let task = self.session.dataTaskWithURL(url!);
        task.resume();
    }
    
    func startCheckingForMessages(sender: NSTimer) {
        let url = NSURL(string: "http://146.148.28.47/SimpleChatHttpServer/ChatServlet?check");
        let task = session.dataTaskWithURL(url!) {[weak self] (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if(error == nil){
                if let theData = data{
                    if theData.length > 0{
                        let s = NSString(data: theData, encoding: NSUTF8StringEncoding)!;
                        dispatch_async(dispatch_get_main_queue(), {
                            self!.label.text = String(s);
                        });
                    }
                    
                }
            }
        }
        task.resume();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

