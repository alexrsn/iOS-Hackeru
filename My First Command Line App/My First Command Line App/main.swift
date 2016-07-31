//
//  main.swift
//  My First Command Line App
//
//  Created by Alex on 13/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation;

let i:Int = -25;
let f:Float = 3.14;

print("Hello, World!\(i) \(f)" );

var i2:UInt8 = 7;
var i3:Int8 = 7;
let c1: Character = "A";
var b1: Bool;
let  b2 = false;
b1 = i2 == 7;
print("the value of b1 is \(b1)");

let rectangle1 = (0, 0, 200, 100);
print(rectangle1.3);
var rectangle2 = (x: 0, y: 0, width: 200, height: 100);
print(rectangle2.width);
//let a = rectangle1.0;
//let b = rectangle1.1;
//let c = rectangle1.2;
//let d = rectangle1.3;
//let (a,b,c,d) = rectangle1;
let (_,_,c,d) = rectangle1;
print(d);
var  s:String?;//? - means that var can be nil(null)
s = nil;
s = "hello";
print(s);
print(s!);

if i < 19{
    print("i is less than 19");
}else{
    print("is is greater than or equal to 19");
}

if let theValueOfS = s{
    print(theValueOfS);
}else{
    print("s is nil");
}

if s != nil{
    print(s!);
}else{
    print("s is nil");
}

typealias Short = Int16;
var t :Short = 15;
typealias Note = String;
let myNote: Note = "hello";

func alex(x: Int, y: Int)->Int{
    print("hello Alex \(x)");
    return x * 55 + y;
}

var x = alex(4, y: 5);
print("x=\(x)");

while x < 300{
    x++;
    print("x=\(x)");
}

for var i = 0; i < 20; i++ {
    
}


for item in 0..<10{  //0..<10 (from 0 to 9) 0...10(from 0 to 10)
    print("item = \(item)");
}














	