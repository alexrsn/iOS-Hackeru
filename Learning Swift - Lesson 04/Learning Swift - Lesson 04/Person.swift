//
//  Person.swift
//  Learning Swift - Lesson 04
//
//  Created by Alex on 24/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class Person{
    
    static var counter: Int = 0;
    private var _name:String = "John";
    var birthYear: Int = 1977{
        willSet{//before change
            
        }
        didSet{//after change
            
        }
    }
    lazy var pet: Dog = Dog();//will be initialized only when used in first time
    
    func description() -> String {
        return "My name is \(_name), and I was born on \(self.birthYear)";
    }
    
    /*
    func setName(name: String){
        _name = name;
    }
    
    func getName() -> String {
        return _name
    }
    */
    
    var name:String{
        get{
            return _name;
        }
        set{
            //before change
            _name = newValue;
            //after change
        }
    }
    
    var stam = "";
    subscript(index: Int) ->String{
        get{
            return stam;
        }
        set{
            stam = newValue;
        }
    }
    
    static func printCounter(){
        print(Person.counter);
    }
    
    
}

class Dog {
    init(){
        print("in init() of Dog");
    }
    
    func setOwner(owner: Person) {
        print(owner._name);
    }
    
    func bark() {
        print("baff baff..");
    }
}

class Employee: Person {
    var employeeNumber: Int = 123;
    var hourlyRate = 35.00;
    
    override func description() -> String {
        return super.description() + "My emploee number is \(employeeNumber)";
    }
}










