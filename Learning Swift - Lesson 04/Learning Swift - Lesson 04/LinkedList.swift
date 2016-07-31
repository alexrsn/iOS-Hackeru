//
//  LinkedList.swift
//  Learning Swift - Lesson 04
//
//  Created by Alex on 24/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class LinkedList{
    private var anchor: Link;
    private var last: Link;
    private var _size: Int;
    private var _next:Link;
    
    init(){
        anchor = Link(value: "anchor");
        last = anchor;
        _next = anchor;
        _size = 0;
    }
    
    var size: Int{
        get{
            return _size;
        }
    }
    
    /*
    var next:String{
        get{
            return _next;
        }
        set{
            _next = newValue;
        }
    }
    */
    
    func add(value: String){
        var last = anchor;
        while (last.next != nil) {
            last = last.next!;
        }
        last.next = Link(value: value);
        _size++;
    }
    
    func indexOf(value: String) -> Int{
        var last = anchor;
        var counter:Int = 0;
        while (last.next != nil) {
            last = last.next!;
            if(last.value == value){
                return counter;
            }
            counter++;
        }
        return -1;
    }
    
    func remove(index: Int){
        if (index >= _size || index < 0){
            return;
        }
        let theOneBefore: Link = getLink(index - 1)!;
        theOneBefore.next = theOneBefore.next!.next;
    }
    
    func getLink(index: Int) -> Link?{
        if (index >= _size || index < 0){
            //TODO: this is an invalid index
            return nil;
        }
        var last = anchor;
        var counter:Int = 0;
        while (last.next != nil && counter++ <= index) {
            last = last.next!;
        }
        return last;
    }
    
    subscript(index: Int)->String{
        get{
            let link = getLink(index);
            if (link != nil){
                return link!.value;
            }else{
                return "wrong index";
            }
        }
        set{
            let link = getLink(index);
            if (link != nil){
                link!.value = newValue;
            }
        }
    }
    
    func runOnAll(runnable: (String)->Void){
        var link = anchor;
        while (link.next != nil) {
            link = link.next!;
            runnable(link.value)
        }
    }
    
    func isEqual(list: LinkedList)->Bool{
        if(self === list){
            return true;
        }
        if(list._size != _size){
            return false;
        }
        var link1 = anchor;
        var link2 = list.anchor;
        while (link1.next != nil) {
            link1 = link1.next!;
            link2 = link2.next!;
            if(link1.value != link2.value){
                return false;
            }
        }
        return true;
    }
    
    func resetNext(){
        _next = anchor;
    }
    
    func next()->String?{
        if(_next.next != nil){
            _next = _next.next!;
            return _next.value;
        }else{
            return nil;
        }
        
    }
    
}

