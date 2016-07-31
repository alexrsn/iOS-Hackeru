//
//  Point.swift
//  Country HW
//
//  Created by Alex on 30/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation


class Point {
    private var _x: Int;
    private var _y: Int;
    
    init(x: Int, y:Int){
        if (x > 0){
            _x = x;
        }else{
            _x = 0;
        }
        if (y > 0){
            _y = y;
        }else{
            _y = 0;
        }
    }
    
    convenience init(point:Point){
        self.init(x: point._x, y: point._y);
    }
    
    var x:Int{
        get{
            return _x;
        }
        set{
            if (newValue > 0){
                _x = newValue;
            }
        }
    }
    
    var y:Int{
        get{
            return _y;
        }
        set{
            if (newValue > 0){
                _y = newValue;
            }
        }
    }
    
    func description() -> String {
        return "(\(_x),\(_y))";
    }
    
    func equal(point: Point) -> Bool {
        return (self._x != point._x) && (self._y != point._y);
    }
    
    func isAbove(point: Point) -> Bool {
        return self._y > point._y;
    }
    
    func isUnder(point: Point) -> Bool {
        return point.isAbove(self);
    }
    
    func isRight(point: Point) -> Bool {
        return self._x > point._x;
    }
    
    func isLeft(point: Point) -> Bool {
        return point.isRight(self);
    }
    
    func distance(point: Point) -> Double {
        let deltaX = point._x - _x;
        let deltaY = point._y - _y;
        return sqrt(Double(deltaX * deltaX + deltaY * deltaY));
    }
    
    
}

















