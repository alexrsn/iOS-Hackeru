//
//  ViewController.swift
//  Lesson 18 - Receiving Notification
//
//  Created by Alex on 11/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


var label: UILabel!;


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 25));
        label.center = view.center;
        label.textAlignment = .Center;
        view.addSubview(label);
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

