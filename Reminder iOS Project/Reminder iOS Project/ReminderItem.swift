//
//  ReminderItem.swift
//  Reminder iOS Project
//
//  Created by Alex on 10/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class ReminderItem {
    var title: String;
    var note: String;
    var dateInMillis: Int;
    var phoneNumber: String;
    var rep: Int;
    var reminderRepeatStrings:[String] = ["None", "Yearly", "Monthly", "Weekly", "Daily", "Hourly"];
    
    
    init(title:String, note:String, dateInMillis:Int, phoneNumber:String, rep:Int) {
        self.title = title;
        self.note = note;
        self.dateInMillis = dateInMillis;
        self.phoneNumber = phoneNumber;
        self.rep = rep;
    }
    
    func getTitle() -> String{
        return title;
    }
    
    func getNote() -> String{
        return note;
    }
    
    func getDateInMillis() -> Int {
        return dateInMillis;
    }
    
    func getPhoneNumber()  -> String{
        return phoneNumber;
    }
    
    func getRepeat() -> Int {
        return rep;
    }
}
