//
//  Person.swift
//  Lesson 18 - Core Data
//
//  Created by Alex on 11/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import CoreData


@objc(Person)class Person: NSManagedObject{
    
    @NSManaged var age: NSNumber;
    @NSManaged var firstName: String;
    @NSManaged var lastName: String;
    
    
}