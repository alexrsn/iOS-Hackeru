//
//  ViewController.swift
//  Lesson 09 - UISlider
//
//  Created by Alex on 13/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var slider: UISlider!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 30));
        slider.center = view.center;
        slider.minimumValue = 0;
        slider.maximumValue = 100;
        slider.value = 50;
        
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged);
        view.addSubview(slider);
        slider.setThumbImage(UIImage(named: "circle"), forState: .Normal);
        //slider.setThumbImage(UIImage(named: "pic03_small"), forState: .Highlighted);
        
        
    }
    
    func sliderValueChanged(sender: UISlider){
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

