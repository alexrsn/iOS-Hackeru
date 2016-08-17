//
//  ThirdViewController.swift
//  Lesson 09 - Navigation
//
//  Created by Alex on 13/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var secondViewController: SecondViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = UIColor.whiteColor();
        
        let button1 = UIButton(type: .System);
        button1.setTitle("go to screen 1", forState: .Normal);
        button1.frame = CGRect(x: 5, y: view.frame.height - 50, width: 100, height: 30);
        button1.addTarget(self, action: "btnGoToScreen1:", forControlEvents: .TouchUpInside);
        view.addSubview(button1);
        
        let button2 = UIButton(type: .System);
        button2.setTitle("go to screen 2", forState: .Normal);
        button2.frame = CGRect(x: view.frame.width - 100 - 5, y: view.frame.height - 50, width: 100, height: 30);
        button2.addTarget(self, action: "btnGoToScreen2:", forControlEvents: .TouchUpInside);
        view.addSubview(button2);
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 80, width: 300, height: 30));
        label.text = "View Controller 3";
        label.center.x = view.center.x;
        view.addSubview(label);
    }
    
    func btnGoToScreen1(sender: UIButton){
        //let secondViewController = presentingViewController as! SecondViewController;
        secondViewController.nextStep = 1;
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func btnGoToScreen2(sender: UIButton){
        secondViewController.nextStep = 2;
        dismissViewControllerAnimated(true, completion: nil);
    }
}
