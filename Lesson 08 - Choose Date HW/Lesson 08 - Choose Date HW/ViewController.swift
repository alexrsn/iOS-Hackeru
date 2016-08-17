//
//  ViewController.swift
//  Lesson 08 - Choose Date HW
//
//  Created by Alex on 07/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    private var picker: UIPickerView!;
    private var okButton: UIButton!;
    private var datePickerDelegate = DatePickerViewDelegate();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = UIPickerView();
        picker.center = view.center;
        picker.delegate = datePickerDelegate;
        picker.dataSource = datePickerDelegate;
        
        okButton = UIButton(type: .System);
        okButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50);
        okButton.setTitle("OK", forState: .Normal);
        okButton.addTarget(self, action: "okClicked:", forControlEvents: .TouchUpInside);
        okButton.center.x = view.center.x;
        okButton.frame.origin.y = picker.frame.maxY + 10;
        
        view.addSubview(picker);
        view.addSubview(okButton);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func okClicked(sender: UIButton) {
        let monthSelected = picker.selectedRowInComponent(0);
        let daySelected = picker.selectedRowInComponent(1);
        var days: Int = 0;
        for var i = 0; i < monthSelected; i++ {
            days += Calendar.daysInMonth[i];
        }
        days += daySelected;
        print("day in week is:\(Calendar.dayInWeek[days%7])");
    }
}

