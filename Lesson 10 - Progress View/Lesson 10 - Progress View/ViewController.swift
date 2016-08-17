//
//  ViewController.swift
//  Lesson 10 - Progress View
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var progressView: UIProgressView!;
    var myProgressView: MyProgressView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myProgressView = MyProgressView(frame: CGRect(x: 10, y: 10, width: 100, height: 10));
        myProgressView.center = view.center;
        myProgressView.progress = 0.3;
        myProgressView.progressColor = UIColor.greenColor();
        myProgressView.baseColor = UIColor.blackColor();
        view.addSubview(myProgressView);
        
        progressView = UIProgressView(progressViewStyle: .Bar);
        progressView.center = view.center;
        progressView.progress = 0.5;
        progressView.trackTintColor = UIColor.grayColor();
        progressView.tintColor = UIColor.blueColor();
        
        
        //view.addSubview(progressView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

