//
//  ViewController.swift
//  Lesson 10 - Calculator
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    
    var textField: UITextField!;
    var button: UIButton!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30));
        textField.center = view.center;
        textField.textAlignment = .Center;
        textField.borderStyle = .RoundedRect;
        textField.delegate = self;
        view.addSubview(textField);
        
        button = UIButton(type: .System);
        button.frame = CGRect(x: 0, y: textField.frame.maxY + 5, width: 200, height: 30);
        button.center.x = view.center.x;
        button.setTitle("Print number", forState: .Normal);
        button.addTarget(self, action: "printNumber:", forControlEvents: .TouchUpInside);
        view.addSubview(button);
    }
    
   
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text as! NSString;
        let wholeText = currentText.stringByReplacingCharactersInRange(range, withString: string);
        return checkTextValid(wholeText);
    }
    
    func checkTextValid(stringToCheck: NSString) -> Bool {
        let length = stringToCheck.lengthOfBytesUsingEncoding(NSUTF8StringEncoding);
        var decimalFound: Bool = false;
        if length > 1 {
            if stringToCheck.characterAtIndex(0) == 48{
                if stringToCheck.characterAtIndex(1) != 46{
                    return false;
                }
            }
        }
        for var i = 0;i < length;i++ {
            if stringToCheck.characterAtIndex(i) == 46{
                if decimalFound || i == 0 {
                    return false;
                }
                decimalFound = true;
            }else if stringToCheck.characterAtIndex(i) < 48 || stringToCheck.characterAtIndex(i) > 57{
                return false;
            }
        }
        return true;
    }
    
    func convertNSStringToFloat(str: NSString) -> Float {
        var result:Float = 0.0;
        var decimalDiv:Float = 1;
        let length = str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding);
        var decimalFound:Bool = false;
        for var i = 0;i < length;i++ {
            if str.characterAtIndex(i) == 46{
                decimalFound = true;
                continue;
            }
            result *= 10;
            result += Float(asciiToInt(str.characterAtIndex(i))!);
            if decimalFound {
                decimalDiv *= 10;
            }
        }
        return result / decimalDiv;
    }
    
    func asciiToInt(char: unichar) -> Int? {
        if char < 48 || char > 57 {
            return nil;
        }
        return Int(char - 48);
    }

    func printNumber(sender: UIButton) {
        print("\(convertNSStringToFloat(textField.text as! NSString))");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

