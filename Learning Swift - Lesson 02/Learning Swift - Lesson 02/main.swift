//
//  main.swift
//  Learning Swift - Lesson 02
//
//  Created by Alex on 17/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

typealias Note = String;
var x: Note;

if(5<7){
    let y = 3;
}
//print(y);//woll not work beaceuse y declared inside the if braces

enum Weekday{
    case Sunday
    case Monday
    case Tueasday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}


var today: Weekday;

today = .Sunday;

if(today == .Sunday){
    print("have a nice week");
}

var arr: [String] = [String]();
arr.append("hello");
arr.append(" ");
arr.append("world");
for s in arr{
    print(s);
}
for var i=0; i<arr.count; i++ {
    print(arr[i]);
}
var arr2 = ["a", "b", "c", 3];

arr2.append("d");

arr2.append(5);

var t: AnyObject = "a";
t = 5;

var arr3 = arr;
arr[0] = "hi";
for s in arr3{
    print(s);
}

var s = "hi";
s += " bye";


















