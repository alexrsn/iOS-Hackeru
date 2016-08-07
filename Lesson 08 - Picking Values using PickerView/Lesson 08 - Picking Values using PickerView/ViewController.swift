//
//  ViewController.swift
//  Lesson 08 - Picking Values using PickerView
//
//  Created by Alex on 07/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


//UIPickerViewDataSource - methods that deals with "what shuld be shown in each line".
//UIPickerViewDelegate - methods that deals with user interactions.

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var picker: UIPickerView!;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = UIPickerView();
        picker.center = view.center;
        picker.delegate = self;
        picker.dataSource = self;
        view.addSubview(picker);
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return 31;
        }else if component == 1{
            return 12;
        }else{
            return 100;
        }
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return "\(row + 1)";
        }else if component == 1{
            return "\(row + 1)";
        }else{
            return "\(row + 2000)";
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1);
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

