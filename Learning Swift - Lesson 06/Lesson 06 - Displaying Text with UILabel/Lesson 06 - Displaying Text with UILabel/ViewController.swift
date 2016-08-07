//
//  ViewController.swift
//  Lesson 06 - Displaying Text with UILabel
//
//  Created by Alex on 31/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!;
    let image = UIImage(named: "lion2");
    var imageView: UIImageView!;
    var lionContainer: UIView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lionHeight:CGFloat = 200;
        let titleHeight:CGFloat = 30;
        let lionWidth:CGFloat = 200;
        let padding:CGFloat = 5;
        
        lionContainer = UIView(frame: CGRect(x: 0, y: 0, width: lionWidth, height: lionHeight + padding + titleHeight));
        lionContainer.center = view.center;
        view.addSubview(lionContainer);
        
        
        imageView = UIImageView(image: image);
        imageView.frame = CGRect(x: 0, y: 0, width: lionContainer.frame.width, height: lionHeight);
        //imageView.center = view.center;
        imageView.contentMode = .ScaleAspectFit;
        //view.addSubview(imageView);
        lionContainer.addSubview(imageView);
        
        //label = UILabel(frame: CGRect(x: (view.frame.width-w)/2, y: 30, width: w, height: 120));
        label = UILabel(frame: CGRect(x: 0, y: lionHeight + padding, width: lionContainer.frame.width, height: titleHeight));
        label.text = "This is lion";
        label.textAlignment = .Center;
        //label.numberOfLines = 1;
        label.backgroundColor = UIColor.redColor();
        label.lineBreakMode = .ByTruncatingMiddle;
        label.font = UIFont.boldSystemFontOfSize(14);
        //label.frame.origin.y = imageView.frame.origin.y + imageView.frame.height;
        //label.frame.origin.y = imageView.frame.maxY;
        
        //view.addSubview(label);
        lionContainer.addSubview(label);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

