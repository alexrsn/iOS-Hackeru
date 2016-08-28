//
//  ViewController.swift
//  Lesson 13 - Long Tasks in Background
//
//  Created by Alex on 24/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()");
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        print("viewDidAppear()");
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        print("viewDidDisappear()");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

