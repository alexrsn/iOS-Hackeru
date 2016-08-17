//
//  ViewController.swift
//  Lesson 09 - UITextField
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var textField: UITextField!;
    var label: UILabel!;
    
    
    func calculateLength(text: String){
        var character = "Character";
        let len = text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding);
        if len != 1 {
            character += "s";
        }
        label.text = "\(len) \(character)";
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text as! NSString;
        let wholeText = currentText.stringByReplacingCharactersInRange(range, withString: string);
        calculateLength(wholeText);
        return true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30));
        textField.center = view.center;
        textField.borderStyle = .RoundedRect;
        textField.contentVerticalAlignment = .Center;
        textField.textAlignment = .Center;
        textField.text = "some text";
        textField.delegate = self;
        view.addSubview(textField);
        
        label = UILabel(frame: CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y - 50, width: textField.frame.width, height: 30));
        view.addSubview(label);
        calculateLength(textField.text!);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}