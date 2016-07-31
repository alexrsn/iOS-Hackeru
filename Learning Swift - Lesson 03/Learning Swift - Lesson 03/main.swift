//
//  main.swift
//  Learning Swift - Lesson 03
//
//  Created by Alex on 20/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

var d1:[String: String];
//d1 = [String: String]();
d1 = ["firstName" : "Alex", "lastName" : "Resin"];
print(d1.keys.count);
d1["firstName"] = nil;//set value to nil will remove the key/value pair
print(d1.keys.count);
if let theValue = d1["firstName"]{
    print(theValue);
}else{
    print("no such key in the dictionary");
}

for (key,value) in d1{
    print("key=\(key) value=\(value)");
}

for key in d1.keys{
    print(key);
}

let x = 3;
if(x == 1){
    
}else if(x == 2){
    
}else if (x == 3){
    
}else{
    
}



switch(x){
case 1:
    print("x is 1");
    break;
case 2:
    print("x is 2");
    break;
case 3:
    print("x is 3");
    break;
case 4:
    print("x is 4");
    break;
default:
    print("x is something else");
}


func byRefFunc(inout x: Int){
    x++;
}

var y = 5;
byRefFunc(&y);
print(y);

func compareIntegers(x: AnyObject, y: AnyObject)->Bool{
    let a = x as! Int;//casting to Int
    let b = y as! Int;
    
    return a > b;
}

func sortArray(inout arr:[AnyObject], compare:(AnyObject, AnyObject)->Bool){
    var isSorted = false;
    var upTo = arr.count - 1;
    while(!isSorted){
        isSorted = true;
        for i in 0 ..< upTo {
            if(compare(arr[i], arr[i+1])){
                let temp = arr[i];
                arr[i] = arr[i+1];
                arr[i+1] = temp;
                isSorted = false;
            }
        }
        upTo--;
    }
}

var numbers: [AnyObject] = [234,4564,4545,6575,34,567];

//sortArray(&numbers, compare: compareIntegers);

sortArray(&numbers, compare: { (x: AnyObject, y: AnyObject) -> Bool in
    let a = x as! Int;//casting to Int
    let b = y as! Int;
    
    return a > b;
});

sortArray(&numbers) { (x: AnyObject, y: AnyObject) -> Bool in
    let a = x as! Int;//casting to Int
    let b = y as! Int;
    
    return a > b;
};


func myFunc2()->Bool {
    return true;
}

var myVar = {() -> Bool in print("inside closure"); return true;};
myVar = myFunc2;
//myVar();

struct Student{
    var firstName = "";
    var lastName = "";
    var classRoom = 0;
    
    func printStudent(){
        print("my name is \(firstName) \(lastName)");
    }
    
    mutating func setFirstName(firstName: String){
        self.firstName = firstName;
    }
}

var s1 = Student();
s1.firstName = "John";
var s2 = s1;
s1.firstName = "Adam";
print(s2.firstName);


class Dog{
    var name: String = "";
    
    func setName(name: String){
        self.name = name;
    }
}

var canvas:[[Bool]] = [[Bool]]();
for _ in 0..<20{
    var row  = [Bool]();
    for _ in 0..<40{
        row.append(false);
    }
    canvas.append(row);
}

let dog1 = Dog();
dog1.name = "snoopy";
var dog2 = dog1;
if(dog1 === dog2){//reference comparison
    print("dog1 and dog2 are equal");
}else{
    print("dog1 and dog2 are NOT equal");
}











