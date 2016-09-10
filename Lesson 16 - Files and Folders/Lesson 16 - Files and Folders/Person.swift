//
//  Person.swift
//  Lesson 16 - Files and Folders
//
//  Created by Alex on 10/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

@objc(Person) class Person: NSObject, NSCoding {
    var firstName: String;
    var lastName: String;
    
    static let firstNameKey = "firstName";
    static let lastNameKey = "lastName";
    
    init(firstName: String, lastName: String){
        self.firstName = firstName;
        self.lastName = lastName;
        super.init();
    }
    
    
    required init(coder aDecoder: NSCoder){
        self.firstName = aDecoder.decodeObjectForKey(Person.firstNameKey) as! String;
        self.lastName = aDecoder.decodeObjectForKey(Person.lastNameKey) as! String;
    }
    
    init(data: NSData){
        var bytes:[UInt8] = [UInt8](count: data.length, repeatedValue: 0);
        data.getBytes(&bytes, length: data.length);
        let firstNameLength = Int(bytes[0]);
        let lastNameLength = Int(bytes[firstNameLength + 1]);
        self.firstName = ViewController.bytesToString(&bytes, offset: 1, length: firstNameLength) as String;
        self.lastName = ViewController.bytesToString(&bytes, offset: firstNameLength + 2, length: lastNameLength) as String;
        
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(firstName, forKey: Person.firstNameKey);
        aCoder.encodeObject(lastName, forKey: Person.lastNameKey);
    }
    
    func toNSData()->NSData{
        let data = NSMutableData();
        var firstNameLength = UInt8(firstName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding));
        var lastNameLength = UInt8(lastName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding));
        data.appendBytes(&firstNameLength, length: 1);
        data.appendData(firstName.dataUsingEncoding(NSUTF8StringEncoding)!);
        data.appendBytes(&lastNameLength, length: 1);
        data.appendData(lastName.dataUsingEncoding(NSUTF8StringEncoding)!);
        return data;
    }
    
    
    
}
