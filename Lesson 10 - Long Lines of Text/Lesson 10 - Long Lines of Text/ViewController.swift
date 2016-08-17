//
//  ViewController.swift
//  Lesson 10 - Long Lines of Text
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textView : UITextView!;
    var fullScreenRect: CGRect!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        fullScreenRect = CGRect(x: 10, y: 30, width: view.frame.width - 20, height: view.frame.height - 30 - 10);
        textView = UITextView(frame: fullScreenRect);
        textView.text = "Some initial text to show on the screen";
        textView.font = UIFont.systemFontOfSize(16);
        view.addSubview(textView);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil);
        
        
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    func handleKeyboardDidShow(notification: NSNotification){
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue;
        
        var keyboardRect = CGRectZero;
        keyboardRectAsObject.getValue(&keyboardRect);
        
        textView.frame = CGRect(x: 10, y: 30, width: view.frame.width - 20, height: view.frame.height - 30 - 10 - keyboardRect.height);
        
    }
    
    
    func handleKeyboardDidHide(notification: NSNotification){
        textView.frame = fullScreenRect;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}












