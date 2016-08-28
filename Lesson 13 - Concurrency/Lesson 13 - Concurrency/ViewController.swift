//
//  ViewController.swift
//  Lesson 13 - Concurrency
//
//  Created by Alex on 24/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button:UIButton!;
    var textField:UITextField!;
    var activityIndicator: UIActivityIndicatorView!;
    var x:Int = 0;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton(type: .System);
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 30);
        button.center = view.center;
        button.setTitle("click me", forState: .Normal);
        button.addTarget(self, action: "handleClick:", forControlEvents: .TouchUpInside);
        view.addSubview(button);
        
        textField = UITextField(frame: CGRect(x: button.frame.origin.x, y: button.frame.origin.y - 50, width: button.frame.width, height: 30));
        textField.borderStyle = .RoundedRect;
        view.addSubview(textField);
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 30, width: 30, height: 30));
        activityIndicator.center.x = view.center.x;
        activityIndicator.color = UIColor.grayColor();
        view.addSubview(activityIndicator);

    }
    
    
    func handleClick(sender: UIButton) {
        
        //GCD - Grand Central Dispatch
        
        //the function "dispatch_get_global_queue" gives us a pointer to a background queue(thread)
        //the function "dispatch_get_main_queue" gives us a pointer to a main queue(thread) / UI queue
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        button.enabled = false;
        button.setTitle("please wait", forState: .Normal);
        activityIndicator.startAnimating();
        dispatch_async(queue) {
            print("begin");
            var x = 0;
            for(var i = 0;i < 1000000000;i++){
                x++;
            }
            //UI operation must be done on the main thread/queue
            let mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, {
                self.textField.text = String(x);
                self.button.enabled = true;
                self.button.setTitle("click me", forState: .Normal);
                self.activityIndicator.stopAnimating();
            });
            print("done");
        }
    }
    
    
    deinit{
        ba
    }
    
//    func handleClick(sender: UIButton) {
//        
//        //GCD - Grand Central Dispatch
//        
//        //the function "dispatch_get_global_queue" gives us a pointer to a background queue(thread)
//        //the function "dispatch_get_main_queue" gives us a pointer to a main queue(thread) / UI queue
//        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(queue) { [weak self]()->Void in
//            print("begin");
//            self!.x = 0;
//            for(var i = 0;i < 1000000000;i++){
//                self!.x++;
//            }
//            print("done");
//            //UI operation must be done on the main thread/queue
//            let mainQueue = dispatch_get_main_queue();
//            dispatch_async(mainQueue, { [weak self]()->Void in
//                self!.textField.text = String(self!.x);
//                });
//            print("done");
//        }
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

