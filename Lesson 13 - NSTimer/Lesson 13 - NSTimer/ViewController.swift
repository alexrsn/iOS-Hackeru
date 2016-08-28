//
//  ViewController.swift
//  Lesson 13 - NSTimer
//
//  Created by Alex on 24/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textView:UITextView!
    var button:UIButton!;
    var timer: NSTimer!;
    var started:Bool = false;
    
    var counter = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 30));
        textView.textAlignment = .Center;
        textView.center = view.center;
        view.addSubview(textView);
        button = UIButton(type: .System);
        button.frame = CGRect(x: textView.frame.origin.x, y: textView.frame.maxY, width: 100, height: 30);
        button.setTitle("Start", forState: .Normal);
        button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside);
        view.addSubview(button);
        
        
        
        
        
    }
    
    
    func buttonClicked(sender: UIButton){
        if(!started){
            started = true;
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "handleTimer:", userInfo: nil, repeats: true);
            button.setTitle("Stop", forState: .Normal)
            
        }else{
            started = false;
            timer.invalidate();
            button.setTitle("Start", forState: .Normal);
        }
        
    }
    
    func handleTimer(sender: NSTimer){
        self.textView.text = String(counter++);
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

