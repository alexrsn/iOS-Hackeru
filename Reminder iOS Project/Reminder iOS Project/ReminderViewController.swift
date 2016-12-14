//
//  AddNewReminderViewController.swift
//  Reminder iOS Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

class ReminderViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate{
    
    var txtTitle:UITextField!;
    var txtNote:UITextField!;
    var imgPhoneIcon:UIImageView!;
    var txtPhone:UITextField!;
    var imgDateIcon:UIImageView!;
    var datePicker:UIDatePicker!;
    var imgTimeIcon:UIImageView!;
    var timePicker:UIDatePicker!;
    var imgRepeatIcon:UIImageView!;
    var repeatPicker:UIPickerView!;
    
    var reminder:Reminder!;
    var btnSave:UIButton!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white;
        navigationItem.title = "Add Reminder";
        
        txtTitle = UITextField(frame: CGRect(x: 0, y: 30 + 40, width: view.frame.width, height: 50));
        txtTitle.placeholder = "Title";
        view.addSubview(txtTitle);
        
        txtNote = UITextField(frame: CGRect(x: 0, y: txtTitle.frame.maxY + 5, width: view.frame.width, height: 50));
        txtNote.placeholder = "Note";
        view.addSubview(txtNote);
        
        let imgPhoneName = UIImage(imageLiteralResourceName: "phone");
        imgPhoneIcon = UIImageView(image: imgPhoneName);
        imgPhoneIcon.frame = CGRect(x: 0, y: txtNote.frame.maxY + 5, width: 50, height: 50);
        view.addSubview(imgPhoneIcon);
        
        txtPhone = UITextField(frame: CGRect(x: imgPhoneIcon.frame.maxX + 5, y: txtNote.frame.maxY + 5, width: view.frame.width - 50 - 5, height: 50));
        txtPhone.placeholder = "Phone Number";
        txtPhone.keyboardType = .phonePad;
        view.addSubview(txtPhone);
        
        let imgDateName = UIImage(imageLiteralResourceName: "date");
        imgDateIcon = UIImageView(image: imgDateName);
        imgDateIcon.frame = CGRect(x: 0, y: imgPhoneIcon.frame.maxY + 5, width: 50, height: 50);
        view.addSubview(imgDateIcon);
        
        datePicker = UIDatePicker(frame: CGRect(x: imgDateIcon.frame.maxX + 5, y: imgPhoneIcon.frame.maxY + 5, width: view.frame.width - 50 - 5, height: 50));
        datePicker.datePickerMode = .dateAndTime;
        view.addSubview(datePicker);
        
        let imgRepeatName = UIImage(imageLiteralResourceName: "repeat");
        imgRepeatIcon = UIImageView(image: imgRepeatName);
        imgRepeatIcon.frame = CGRect(x: 0, y: imgDateIcon.frame.maxY + 5, width: 50, height: 50);
        view.addSubview(imgRepeatIcon);
        
        
        repeatPicker = UIPickerView(frame: CGRect(x: imgRepeatIcon.frame.maxX + 5, y: datePicker.frame.maxY + 5, width: view.frame.width - 50 - 5, height: 50));
        repeatPicker.dataSource = self;
        repeatPicker.delegate = self;
        view.addSubview(repeatPicker);
        
        
        btnSave = UIButton(type: .system);
        btnSave.frame = CGRect(x: 0, y: repeatPicker.frame.maxY + 5, width: view.frame.width, height: 50);
        btnSave.setTitle("Save reminder", for: .normal);
        btnSave.addTarget(self, action: #selector(btnSaveClicked), for: .touchUpInside);
        view.addSubview(btnSave);
        
        
        if let reminder = reminder {
            navigationItem.title = "Edit Reminder";
            txtTitle.text = reminder.getTitle();
            txtNote.text = reminder.getNote();
            txtPhone.text = reminder.getPhoneNumber();
            datePicker.date = reminder.getDate();
            repeatPicker.selectRow(reminder.getRepeat(), inComponent: 0, animated: true);
        }
    }
    
    func btnSaveClicked(sender: UIButton) {
        if saveReminder() {
            dismiss(animated: true, completion: nil);
            navigationController?.popViewController(animated: true);
        }
        
    }
    
    func saveReminder() -> Bool {
        // Validation of required fields
        if txtTitle.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "Please enter title!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false;
        }
        // Creating object
        if reminder == nil {
            reminder = Reminder();
        }
        // Saving object
        if let reminder = reminder {
            reminder.title = txtTitle.text!;
            reminder.note = txtNote.text!;
            reminder.phoneNumber = txtPhone.text!;
            reminder.date = datePicker.date;
            reminder.rep = repeatPicker.selectedRow(inComponent: 0);
            CoreDataManager.instance.saveContext();
        }
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "None";
        case 1:
            return "Yearly";
        case 2:
            return "Montly"
        case 3:
            return "Weekly";
        case 4:
            return "Daily";
        case 5:
            return "Hourly";
        default:
            return "None";
        }
    }
    
    
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


