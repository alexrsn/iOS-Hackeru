//
//  ViewController.swift
//  Lesson 16 - Address Book
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate{

    var contactPicker: CNContactPickerViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnShowContactPicker = UIButton(type: .System);
        btnShowContactPicker.frame = CGRect(x: 0, y: 0, width: 300, height: 30);
        btnShowContactPicker.center = view.center;
        btnShowContactPicker.setTitle("pick from contacts", forState: .Normal);
        btnShowContactPicker.addTarget(self, action: "btnShowContactPicker:", forControlEvents: .TouchUpInside);
        view.addSubview(btnShowContactPicker);
        
        contactPicker = CNContactPickerViewController();
        contactPicker.delegate = self;
        
        
    }

    func btnShowContactPicker (sender: UIButton){
        presentViewController(contactPicker, animated: true, completion: nil);
    }

    
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        print("user canceled")
    }
    
    
    /*
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        print("did select \(contact.givenName)");
    }
    */
    
    /*
    func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]) {
        for c in contacts {
            print("did select \(c.givenName)");
        }
    }
    */
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        print("did select property \(contactProperty.key) \(contactProperty.value)");
        if contactProperty.value is CNPhoneNumber{
            let phone = contactProperty.value as! CNPhoneNumber;
            print(phone.stringValue);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

