//
//  Person.swift
//  Learning Swift - Lesson 05
//
//  Created by Alex on 27/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class Person{
    var name: String!;// ! - means disable checks (like nil or initialized) on this var
    var age: Int;
    private var _lastName: String;
    
    func description() -> String{
        return "I'm \(self.name) and I'm \(self.age) years old.";
    }
    
//    convenience init(){
//        self.init(name: "John", age: 0, lastName: "Smith");
//    }
    
    init(name: String, age: Int, lastName: String){
        self.name = name;
        self.age = age;
        _lastName = lastName;
    }
    
    convenience init(name: String, age: Int){
        self.init(name: name, age: age, lastName: "Smith");

    }
    
    func doPersonThings(){
        print("doing person things");
    }
    
    var lastName:String {
        get{
            return _lastName;
        }
        set{
            _lastName = newValue;
        }
    }
    
    deinit{//this is destructor (runs when garbage collector destroys the object)
        print("in destructor");
    }
    
}
