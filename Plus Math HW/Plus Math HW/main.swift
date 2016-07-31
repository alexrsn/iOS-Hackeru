//
//  main.swift
//  Plus Math HW
//
//  Created by Alex on 13/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation


func distance (x: Int, y: Int)->Int{
    var small = x;
    var large = y;
    if small > large{
        small = y;
        large = x;
    }
    var result = 0;
    while (small + result < large){
        result++;
    }
    return result;
}

print("the distance is:\(distance(7, y: 3))");

func product (x: Int, y: Int)->Int{
    var small = x;
    var large = y;
    if small > large{
        small = y;
        large = x;
    }
    var result = 0;
    for (var i = 0; i < small; i++){
        result += large;
    }
    return result;
}

print("the product is:\(product(7, y: 3))");

func quotient (x: Int, y: Int)->Int?{
    if(y == 0){
        return nil;
    }
    var sum = y;
    var result = 0;
    while (sum <= x){
        sum += y;
        result++;
    }
    return result;
}

if let q = quotient(10, y: 3){
    print("the quotient is:\(q)");
}else{
    print("error! probably division by zero");
}

func remainder (x: Int,y: Int)->Int?{
    if(y == 0){
        return nil;
    }
    return distance(x, y: product(quotient(x, y: y)!, y: y));
}

if let r = remainder(10, y: 3){
    print("the remainder is:\(r)");
}else{
    print("error! probably division by zero");
}

func division(x: Int, y: Int)->(Int,Int)?{
    if(y == 0){
        return nil;
    }
    var sum = y;
    var largestProductOfY = 0;
    var result = 0;
    while (sum <= x){
        sum += y;
        largestProductOfY += y;
        result++;
    }
    return (result,distance(x, y: largestProductOfY));
}


func power(x: Int, y: Int)->Int?{
    if(x == 0){
        if(y == 0){
            return nil;
        }
        return 0;
    }
    if (y == 0 || x == 1){
        return 1;
    }
    var result = x;
    for i in 1..<y{
        result *= x;
    }
    return result;
}

if let p = power(3, y: 2){
    print("x power y:\(p)");
}else{
    print("error! not defined");
}

func powerRecursive(x: Int, y: Int)->Int?{
    if(x == 0){
        if(y == 0){
            return nil;
        }
        return 0;
    }
    if (y == 0 || x == 1){
        return 1;
    }
    return x * powerRecursive(x, y: y-1)!;
}

if let p2 = powerRecursive(2, y: 8){
    print("x power y:\(p2)");
}else{
    print("error! not defined");
}

func sqrt(x: Int)->Int{
    var result = 0;
    while(result * result < x){
        result++;
    }
    return result;
}

print("sqrt of x is:\(sqrt(13))");

func sumOfNumberDigits(var x: Int)->Int{
    var result = 0;
    while (x != 0){
        result += x % 10;
        x /= 10;
    }
    return result;
}

print("sum of number digits is:\(sumOfNumberDigits(1346))");

func maxDigitInNumber(var x: Int)->Int{
    var max = x % 10;
    while (x > 0){
        if (max < x % 10){
            max = x % 10;
        }
        x /= 10;
    }
    return max;
}

print("max digit in number is:\(maxDigitInNumber(13463))");


func reverseNumber(x: Int)->Int{
    var num = x;
    var result = 0;
    while (num > 0){
        result *= 10;
        result += num % 10;
        num /= 10;
    }
    return result;
}

print("reverse number is:\(reverseNumber(13463))");


func sumOfArray(x: [Int])->Int{
    var result = 0;
    for i in x{
        result += i;
    }
    return result;
}

print("sum of array is:\(sumOfArray([1, 3, 5, 2]))");


func maxNumberInArray(x: [Int])->Int{
    var max = x[0];
    for i in x{
        if(i > max){
            max = i;
        }
    }
    return max;
}

print("max number in array is:\(maxNumberInArray([1, 9, 5, 2]))");

func averageOfArray(x: [Int])->Double{
    let sum = sumOfArray(x);
    return Double(sum) / Double(x.count);
}

print("average number in array is:\(averageOfArray([1, 9, 3, 5]))");

func isArrayIncluded(arrA: [Int], arrB: [Int])->Bool{
    if(arrB.count == 0){
        return true;
    }
    var found: Bool;
    for var i = 0;i <= arrA.count - arrB.count;i++ {
        if(arrA[i]==arrB[0]){
            found = true;
            for var j = 1;j < arrB.count;j++ {
                if(arrA[i+j] != arrB[j]){
                    found = false;
                    break;
                }
            }
            if(found){
                return true;
            }
        }
    }
    return false;
}

if(isArrayIncluded([1, 2, 4, 6, 7, 8, 9], arrB: [4, 6, 7, 8, 9])){
    print("array B included in A");
}else{
    print("array B not included in A");
}

func drawRectangle(x: Int, y: Int, width: Int, height: Int){
    for _ in 0..<y{
        print();
    }
    var firstAndLastLine = "";
    for _ in 0..<x{
        firstAndLastLine += " ";
    }
    for _ in 0..<width{
        firstAndLastLine += "* ";
    }
    print(firstAndLastLine);
    for _ in 0..<height - 2{
        var line = "";
        for _ in 0..<x{
            line += " ";
        }
        line += "* ";
        for _ in 0..<width - 2{
            line += "  ";
        }
        line += "* ";
        print(line);
    }
    print(firstAndLastLine);
}

drawRectangle(10, y: 3, width: 5, height: 5);















	