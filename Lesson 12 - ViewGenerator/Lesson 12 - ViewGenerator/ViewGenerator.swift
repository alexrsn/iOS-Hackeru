//
//  ViewGenerator.swift
//  Lesson 12 - ViewGenerator
//
//  Created by Alex on 22/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


enum Direction{
    case Horizontal;
    case Vertical;
}

 class ViewGenerator: NSObject { //Vertical Linear Layout
    
    var view:UIView;
    var max: CGFloat = 10;
    let margin:CGFloat = 5;
    
    var direction: Direction!;
    
    var buttonActions:[(UIButton)->Void];
    
    init(view: UIView){
        self.view = view;
        buttonActions = [];
    }
    
    
    func addLabel(text: String) -> UILabel{
        let label = UILabel(frame: CGRect(x: margin, y: max, width: view.frame.width - 2*margin, height: 30));
        label.text = text;
        label.textAlignment = .Center;
        view.addSubview(label);
        max += 30 + margin;
        return label;
    }
    
    
    func addTextField(placeholder: String)->UITextField{
        let textField = UITextField(frame: CGRect(x: margin, y: max, width: view.frame.width - 2*margin, height: 30));
        textField.placeholder = placeholder;
        textField.borderStyle = .RoundedRect;
        view.addSubview(textField);
        max += 30 + margin;
        return textField;
    }
    
    
    func addButton(text: String, whatToDo: (sender: UIButton)->Void) ->UIButton{
        let button = UIButton(type: .System);
        button.frame = CGRect(x: margin, y: max, width: view.frame.width - 2*margin, height: 30);
        button.setTitle(text, forState: .Normal);
        button.tag = buttonActions.count;
        button.addTarget(self, action: "handleClick:", forControlEvents: .TouchUpInside);
        buttonActions.append(whatToDo);
        view.addSubview(button);
        max += 30 + margin;
        return button;
    }
    
    func handleClick(sender: UIButton){
        buttonActions[sender.tag](sender);
    }
    
}