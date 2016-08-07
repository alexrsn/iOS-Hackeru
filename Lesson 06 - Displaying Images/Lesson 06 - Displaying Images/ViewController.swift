//
//  ViewController.swift
//  Lesson 06 - Displaying Images
//
//  Created by Alex on 31/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let image = UIImage(named: "lion");
    var imageView: UIImageView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageView = UIImageView(image: image);
        imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 40, height: 40));
        imageView.image = image;
        imageView.contentMode = .ScaleAspectFill
        imageView.center = view.center;
        view.addSubview(imageView);
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

