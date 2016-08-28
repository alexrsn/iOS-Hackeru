//
//  ViewController.swift
//  Lesson 12 - ViewGenerator
//
//  Created by Alex on 22/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewGenerator: ViewGenerator!;
    var label: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        viewGenerator = ViewGenerator(view: view);
        label = viewGenerator.addLabel("title to my app");
        viewGenerator.addLabel("another label in my app");
        viewGenerator.addTextField("enter something");
        viewGenerator.addButton("click me") { (sender) in
            print("clicked!");
        }
        
        viewGenerator.addButton("click that") { (sender) in
            self.label.text = "you see?";
        }
    }
    
}
