//
//  ViewController.swift
//  Lesson 09 - UISegmentedControl
//
//  Created by Alex on 13/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var segmentedControl: UISegmentedControl!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segments = ["Mac", UIImage(named: "angry")!, "Linux", "Windows"];
        
        segmentedControl = UISegmentedControl(items: segments);
        segmentedControl.center = view.center;
        segmentedControl.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents: .ValueChanged);
        
        segmentedControl.selectedSegmentIndex = 2;
        view.addSubview(segmentedControl);
        
        
    }
    
    func segmentedControlValueChanged(sender: UISegmentedControl){
        print("selected index: \(sender.selectedSegmentIndex)");
        print("selected value: \(sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)) ");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

