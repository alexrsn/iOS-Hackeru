//
//  ViewController.swift
//  Lesson 11 - Dismissing the Keyboard
//
//  Created by Alex on 17/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    var textField:UITextField!;
    var button: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = UITextField(frame: CGRect(x: 0, y: 50, width: 150, height: 30));
        textField.borderStyle = .RoundedRect;
        textField.center.x = view.center.x;
        textField.placeholder = "Write here...";
        textField.delegate = self;
        view.addSubview(textField);
        
        button = UIButton(type: .System);
        button.setTitle("click me", forState: .Normal);
        button.frame = CGRect(x: textField.frame.origin.x, y: textField.frame.maxY + 5, width: textField.frame.width, height: 30);
        button.addTarget(self, action: "btnClicked:", forControlEvents: .TouchUpInside);
        view.addSubview(button);

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:");
        view.addGestureRecognizer(tapGestureRecognizer);
        
        
        
        
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        textField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func btnClicked(sender: UIButton) {
        textField.resignFirstResponder();
        print("clicked");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


















