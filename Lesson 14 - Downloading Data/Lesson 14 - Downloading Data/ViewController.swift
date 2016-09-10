//
//  ViewController.swift
//  Lesson 14 - Downloading Data
//
//  Created by Alex on 28/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


extension NSURLSessionTask{
    func start(){
        self.resume();
    }
}

class ViewController: UIViewController, NSURLSessionDataDelegate {
    
    var session: NSURLSession!;
    var data:NSMutableData!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        let url = NSURL(string: "http://www.ynet.co.il");
        
        let task = session.dataTaskWithURL(url!) { [weak self] (data: NSData?, response: NSURLResponse?, error: NSError?) in
            print("done");
            if(error == nil){
                if let theData = data{
                    if theData.length > 0{
                        let s = NSString(data: theData, encoding: NSUTF8StringEncoding)!;
                        //print(s);
                    }
                    
                }
            }else{
                print("baasa...");
            }
            self!.session.finishTasksAndInvalidate();
            
        }
        
        //data = NSMutableData();
        //let task = session.dataTaskWithURL(url!);
        task.start();
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error == nil{
            print("complete");
            
            let d = NSData(bytes: self.data.bytes, length: self.data.length);
            
            let s = NSString(data: d, encoding: NSUTF8StringEncoding);
            print(s);
        }
        session.finishTasksAndInvalidate();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

