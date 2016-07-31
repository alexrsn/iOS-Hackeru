//
//  main.swift
//  Learning Swift - Lesson 05
//
//  Created by Alex on 27/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

/*
class Employee: Person {
    var employeeNumber = 1234567;
    var hourlyRate = 33.0;
    
    init(){
        super.init(name: "John", age: 20, lastName: "Smith");
    }
    
    init(person: Person){
        super.init(name: person.name, age: person.age, lastName: person.lastName);
    }
    
    func doEmployeeThings(){
        print("doing employee things");
    }
    
    override func description() -> String {
        return super.description() + " My hourly rate is \(self.hourlyRate )";
    }
}

var p1 = Person(name: "Alex", age: 30);
p1.name = "Matt";
p1.lastName = "Campbell";
p1.age = 40;
print(p1.description());


var e1:Person? = Employee();
print(e1!.description());
//e1 = nil;
if e1 is Employee{
    var e2 = e1 as! Employee;//casting to Employee}
}

var e3 = Employee(person: p1);

let f1 = 9.99;
let i1 = Int(f1);
let d1 = Double(f1);
let b1 = Bool(f1);//0 - false, other - true
let s1 = String(f1);
print(i1);


/*
 //Strong reference cycle (when two objects has reference one to another and you lose pointer to them
 //they will never be collected by garbage collector
 
 class A{
 var b: B?;
 deinit{
 print("in deinit of A");
 }
 }
 
 class B{
 weak var a: A?;//weak solves this problem
 deinit{
 print("in deinit of B");
 }
 }
 
 
 var a:A? = A();
 var b:B? = B();
 a!.b = b;
 b!.a = a;
 a = nil;
 b = nil;
 */

class Shape{
    
    var pricePerUnit: Double = 0;
    
    func area()->Double{
        return 0.0;
    }
    
    func getTotalPrice() -> Double{
        return area() * pricePerUnit;
    }
}

class Square: Shape {
    var side: Double = 0;
    
    override func area() -> Double {
        return side * side;
    }
}

let s = Square();
s.pricePerUnit = 10;
s.side = 10;
print(s.getTotalPrice());

extension Person{
    func printYourSelf() {
        print(self.description());
    }
}
p1.printYourSelf()

let myString = "hello";
extension String{
    func printIt() {
        print(self);
    }
}
myString.printIt();
*/


/*
class MySuperClass {
    
}

protocol MyProtocol {//like interface in java
    func someFunc();
}

class MyClass: MySuperClass, MyProtocol {//can extend at most one class and it must be in first place
    func someFunc() {
        print("some func");
    }
}
let p = MyClass();

class MyOtherClass {//similar to listener in java
    var delegate : MyProtocol?
    
    func SomethingHappened(){
        print("something happend");
        if let theDelegate = delegate{
            theDelegate.someFunc();
        }
    }
    
}

let myOtherClass = MyOtherClass();
myOtherClass.delegate = p;

*/


let p = Project();
p.name = "Cook Dinner";

let taskNames = ["Choose Menu", "Buy Groceries", "Prepare Ingredients", "Cook Food"];

for name in taskNames{
    let t = Task();
    t.name = name;
    t.delegate = p;
    p.listOfTasks.append(t);
}

p.listOfTasks[0].done();
p.listOfTasks[1].done();
p.listOfTasks[2].done();
p.listOfTasks[3].done();







