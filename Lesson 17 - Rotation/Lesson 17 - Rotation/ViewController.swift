//
//  ViewController.swift
//  Lesson 17 - Rotation
//
//  Created by Alex on 10/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var x = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        x++;
        print("in viewDidLoad");
    }
    
    @IBAction func btnClicked(sender: UIButton) {
        print("x=\(x) view frame \(view.frame.width)");
    }
    
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        print("did rotate");
        switch toInterfaceOrientation {
        case .LandscapeLeft:
            print("LandscapeLeft");
        case .LandscapeRight:
            print("LandscapeRight");
        case .Portrait:
            print("Portrait");
        case .PortraitUpsideDown:
            print("PortraitUpsideDown");
        default:
            print("other");
        }
    }
    
    func isPortrait()->Bool{
        return view.frame.width < view.frame.height;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
