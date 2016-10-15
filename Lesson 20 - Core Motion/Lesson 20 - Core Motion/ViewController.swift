//
//  ViewController.swift
//  Lesson 20 - Core Motion
//
//  Created by Alex on 18/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let motionManager = CMMotionManager();
        if motionManager.isGyroAvailable {
            
        }
        
        if motionManager.isAccelerometerAvailable{
            motionManager.startAccelerometerUpdates(to: OperationQueue(), withHandler: { (data:CMAccelerometerData?, error: Error?) in
                if let theData = data{
                    print("X: \(theData.acceleration.x) Y: \(theData.acceleration.y) Z: \(theData.acceleration.z)");
                }
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

