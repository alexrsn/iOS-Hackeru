//
//  ViewController.swift
//  Lesson 14 - Gesture Recognizers
//
//  Created by Alex on 28/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lblHello: UILabel!;
    
    //1. swipe
    var swipeGestureRecognizer: UISwipeGestureRecognizer!;
    
    //2. rotation
    var rotationAngle:CGFloat = 0;
    var rotationRecognizer: UIRotationGestureRecognizer!;
    
    //3. pinch
    var pinchGestureRecognizer: UIPinchGestureRecognizer!;
    
    //4. pan
    var panGestureRecognizer: UIPanGestureRecognizer!;
    
    //5. long-press
    var longPressGesureRecognizer: UILongPressGestureRecognizer!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //there are 6 gestures:
        //1. swipe
        //2. rotation
        //3. pinch
        //4. pan
        //5. long-press
        //6. tap

        lblHello = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30));
        lblHello.font = UIFont.systemFontOfSize(60);
        lblHello.userInteractionEnabled = true;
        lblHello.text = "Hello";
        lblHello.sizeToFit();
        lblHello.center = view.center;
        view.addSubview(lblHello);
        
        /*
        //1. swipe
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipes:");
        swipeGestureRecognizer.direction = .Left;
        swipeGestureRecognizer.numberOfTouchesRequired = 2;
        view.addGestureRecognizer(swipeGestureRecognizer);
        */
        
        
        /*
        //2. rotation
        rotationRecognizer = UIRotationGestureRecognizer(target: self, action: "handleRotation:");
        view.addGestureRecognizer(rotationRecognizer);
        */
        
        //3. pinch
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePinches:");
        lblHello.addGestureRecognizer(pinchGestureRecognizer);
        
        /*
        //4. pan
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGestures:");
        lblHello.addGestureRecognizer(panGestureRecognizer);
        panGestureRecognizer.minimumNumberOfTouches = 1;
        panGestureRecognizer.maximumNumberOfTouches = 1;
        */
        
        
        /*
        //5. long-ppress
        longPressGesureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:");
        view.addGestureRecognizer(longPressGesureRecognizer);
        longPressGesureRecognizer.numberOfTouchesRequired = 2;
        longPressGesureRecognizer.allowableMovement = 10;
        longPressGesureRecognizer.minimumPressDuration = 1;
        */
        
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
    
    func handlePinches(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
    }
    
    func handlePanGestures(sender: UIPanGestureRecognizer) {
        if sender.state != .Ended && sender.state != .Failed{
            let location = sender.locationInView(sender.view!.superview!);
            sender.view!.center = location;
        }
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended{
            print("long press");
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

