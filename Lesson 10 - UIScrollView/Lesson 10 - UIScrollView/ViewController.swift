//
//  ViewController.swift
//  Lesson 10 - UIScrollView
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView!;
    var scrollView: UIScrollView!;
    let image = UIImage(named: "lion");
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: image);
        scrollView = UIScrollView(frame: view.frame);
        scrollView.addSubview(imageView);
        scrollView.contentSize = imageView.frame.size;
        view.addSubview(scrollView);
        scrollView.delegate = self;

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.alpha = 0.5;
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollView.alpha = 1;
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.alpha = 1;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

