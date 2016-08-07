//
//  ViewController.swift
//  Lesson 08 - Choose Date HW
//
//  Created by Alex on 07/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{

    private let dayInWeek = ["Friday","Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday"];
    private let monthName = ["January","February","March","April","May","June","July","August","September","October", "November","December"];
    private let daysInMonth = [31,29,31,30,31,30,31,31,30,31,30,31];
    private var picker: UIPickerView!;
    private var okButton: UIButton!;
    private var monthSelected = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = UIPickerView();
        picker.center = view.center;
        picker.delegate = self;
        picker.dataSource = self;
        
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

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2;
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return 12;
        }else{
            return daysInMonth[monthSelected];
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return "\(monthName[row])";
        }else{
            return "\(row + 1)";
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            monthSelected = row;
            pickerView.reloadComponent(1)
        }
    }
    
    func okClicked(sender: UIButton) {
        let monthSelected = picker.selectedRowInComponent(0);
        let daySelected = picker.selectedRowInComponent(1);
        var days: Int = 0;
        for var i = 0; i < monthSelected; i++ {
            days += daysInMonth[i];
        }
        days += daySelected;
        print("day in week is:\(dayInWeek[days%7])");
    }
}

