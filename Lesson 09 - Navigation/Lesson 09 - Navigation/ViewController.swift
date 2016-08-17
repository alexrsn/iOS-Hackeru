//
//  ViewController.swift
//  Lesson 09 - Navigation
//
//  Created by Alex on 13/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var secondViewController: SecondViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let button1 = UIButton(type: .System);
        button1.setTitle("go to screen 2", forState: .Normal);
        button1.frame = CGRect(x: 5, y: view.frame.height - 50, width: 100, height: 30);
        button1.addTarget(self, action: "btnGoToScreen2:", forControlEvents: .TouchUpInside);
        view.addSubview(button1);
        
        let button2 = UIButton(type: .System);
        button2.setTitle("go to screen 3", forState: .Normal);
        button2.frame = CGRect(x: view.frame.width - 100 - 5, y: view.frame.height - 50, width: 100, height: 30);
        button2.addTarget(self, action: "btnGoToScreen3:", forControlEvents: .TouchUpInside);
        view.addSubview(button2);
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 80, width: 300, height: 30));
        label.text = "View Controller 1";
        label.center.x = view.center.x;
        view.addSubview(label);
        
    }
    
    
    func btnGoToScreen2(sender: UIButton){
        if(secondViewController == nil){
            secondViewController = SecondViewController();
        }
        secondViewController.nextStep = 2;
        presentViewController(secondViewController, animated: true, completion: nil);
    }
    
    func btnGoToScreen3(sender: UIButton){
        if(secondViewController == nil){
            secondViewController = SecondViewController();
        }
        secondViewController.nextStep = 3;
        presentViewController(secondViewController, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

