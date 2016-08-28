//
//  ViewController.swift
//  Lesson 14 - Gesture Recognizers
//
//  Created by Alex on 28/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var swipeGestureRecognizer: UISwipeGestureRecognizer!;
    
    var lblHello: UILabel!;
    var rotationAngle:CGFloat = 0;
    var rotationRecognizer: UIRotationGestureRecognizer!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //there are 6 gestures:
        //1. swipe
        //2. rotation
        //3. pinch
        //4. pan
        //5. long-press
        //6. tap

        
        /*
        //1. swipe
         
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipes:");
        swipeGestureRecognizer.direction = .Left;
        swipeGestureRecognizer.numberOfTouchesRequired = 2;
        view.addGestureRecognizer(swipeGestureRecognizer);
        */
        
        
        //2. rotation
        lblHello = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30));
        lblHello.font = UIFont.systemFontOfSize(16);
        lblHello.text = "Hello";
        lblHello.sizeToFit();
        lblHello.center = view.center;
        view.addSubview(lblHello);
        
        
        rotationRecognizer = UIRotationGestureRecognizer(target: self, action: "handleRotation:");
        view.addGestureRecognizer(rotationRecognizer);
        
        
    }

    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        print("swipe");
        if sender.direction == .Left{
            print("left");
        }
        
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer) {
        lblHello.transform = CGAffineTransformMakeRotation(rotationAngle + sender.rotation);
        if sender.state == .Ended{
            rotationAngle += sender.rotation;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

