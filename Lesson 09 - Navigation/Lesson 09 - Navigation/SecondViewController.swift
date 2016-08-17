//
//  SecondViewController.swift
//  Lesson 09 - Navigation
//
//  Created by Alex on 13/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var nextStep:Int = 2;
    var thirdViewController: ThirdViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        view.backgroundColor = UIColor.whiteColor();
        
        let button1 = UIButton(type: .System);
        button1.setTitle("go to screen 1", forState: .Normal);
        button1.frame = CGRect(x: 5, y: view.frame.height - 50, width: 100, height: 30);
        button1.addTarget(self, action: "btnGoToScreen1:", forControlEvents: .TouchUpInside);
        view.addSubview(button1);
        
        let button2 = UIButton(type: .System);
        button2.setTitle("go to screen 3", forState: .Normal);
        button2.frame = CGRect(x: view.frame.width - 100 - 5, y: view.frame.height - 50, width: 100, height: 30);
        button2.addTarget(self, action: "btnGoToScreen3:", forControlEvents: .TouchUpInside);
        view.addSubview(button2);
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 80, width: 300, height: 30));
        label.text = "View Controller 2";
        label.center.x = view.center.x;
        view.addSubview(label);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        
        if(thirdViewController != nil){
            thirdViewController.secondViewController = nil;
        }
        
        switch nextStep {
        case 1:
            dismissViewControllerAnimated(true, completion: nil);
        case 2:
            break;
        case 3:
            goToThirdViewController();
        default:
            break;
        }
        
        
    }
    
    
    func goToThirdViewController(){
        if(thirdViewController == nil){
            thirdViewController = ThirdViewController();
        }
        thirdViewController.secondViewController = self;
        presentViewController(thirdViewController, animated: true, completion: nil);
    }
    
    
    func btnGoToScreen1(sender: UIButton){
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    func btnGoToScreen3(sender: UIButton){
        goToThirdViewController();
    }
}