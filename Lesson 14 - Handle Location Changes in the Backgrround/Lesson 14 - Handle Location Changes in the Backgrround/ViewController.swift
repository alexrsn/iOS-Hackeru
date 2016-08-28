//
//  ViewController.swift
//  Lesson 14 - Handle Location Changes in the Backgrround
//
//  Created by Alex on 28/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lblLatitude: UILabel!;
    var lblLongitude: UILabel!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.viewController = self;

        lblLatitude = UILabel(frame: CGRect(x: 10, y: 30, width: view.frame.width - 20, height: 30));
        view.addSubview(lblLatitude);
        lblLongitude = UILabel(frame: CGRect(x: 10, y: 65, width: view.frame.width - 20, height: 30));
        view.addSubview(lblLongitude);
    }
    
    func locationChanged(lat: Double, long: Double){
        lblLatitude.text = String(lat);
        lblLongitude.text = String(long);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

