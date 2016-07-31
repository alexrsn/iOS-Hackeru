//
//  main.swift
//  Learning Swift - Lesson 04
//
//  Created by Alex on 24/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

var p1 = Person();
Person.counter = 15;
p1.name = "Adam";
print(p1.name);
p1.birthYear = 1950;
p1.pet.bark();
print(p1.description());
Person.printCounter();

//using subscript
p1[3] = "hi";
print(p1[2]);

let linkedList = LinkedList();

linkedList.add("hello");
linkedList.add("how");
linkedList.add("are");
linkedList.add("you");

linkedList.runOnAll { (value: String) in
    print(value);
}

//print(linkedList[2]);

print();

linkedList.remove(2);

//print(linkedList.indexOf("are"));

//linkedList[2] = "new value";

//print(linkedList[2]);

linkedList.runOnAll { (value: String) in
    print(value);
}

print("again all items:");
linkedList.resetNext();
while(true){
    if let theValue = linkedList.next() {
        print(theValue);
    }else{
        break;
    }
}

linkedList.resetNext();
var s:String?;
/*
 while((s = linkedList.next()) != nil){
 
 }
 */
while let theValue = linkedList.next() {
    print(theValue);
}

var e1:Person = Employee();
print(e1.description());













