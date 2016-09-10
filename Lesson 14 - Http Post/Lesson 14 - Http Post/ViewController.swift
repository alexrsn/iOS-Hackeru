//
//  ViewController.swift
//  Lesson 14 - Http Post
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
    var receivedData: NSMutableData!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        
        let dict:[NSString : AnyObject] =
            [
                "First name" : "Elad",
                "Last name" : "Lavi",
                "Age" : 35,
                "Friends" : ["Nadav", "Sela"]
        ]
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted);
            //let dataToUpload = "Hi Server, How are you today?".dataUsingEncoding(NSUTF8StringEncoding)!;
            let m = NSMutableData();
            receivedData = NSMutableData();
            session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
            let url = NSURL(string: "http://localhost:8080/MainServlet");
            let request = NSMutableURLRequest(URL: url!);
            request.HTTPMethod = "POST";
            let task = session.uploadTaskWithRequest(request, fromData: jsonData);
            task.start();
        }catch{
            
        }
        
        
        
        
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error == nil{
            do{
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments) as! NSDictionary;
                let numbers = jsonObject["numbers"] as! NSArray;
                print(numbers[0]);
            }catch{
                
            }
            
            //let s = NSString(data: receivedData, encoding: NSUTF8StringEncoding) as! String;
            //print(s);
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        receivedData.appendData(data);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}