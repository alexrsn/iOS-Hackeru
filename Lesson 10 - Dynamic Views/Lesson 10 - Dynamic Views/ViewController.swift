//
//  ViewController.swift
//  Lesson 10 - Dynamic Views
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //1. gravity
    
    var squareView: UIView!;
    var animator: UIDynamicAnimator!;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80));
        squareView.backgroundColor = UIColor.blueColor();
        squareView.center = view.center;
        view.addSubview(squareView);
        
        animator = UIDynamicAnimator(referenceView: view);
        let gravity = UIGravityBehavior(items: [squareView]);
        animator.addBehavior(gravity);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

