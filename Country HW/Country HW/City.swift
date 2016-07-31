//
//  City.swift
//  Country HW
//
//  Created by Alex on 30/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class City {
    private var _cityName: String;
    private var _cityCenter: Point;
    private var _numOfResidents: Int64;
    
    init(cityName: String, cityCenter: Point, numOfResidents: Int64){
        _cityName = cityName;
        _cityCenter = cityCenter;
        if(numOfResidents < 0){
            _numOfResidents = 0;
        }else{
            _numOfResidents = numOfResidents;
        }
        
    }
    
    convenience init(otherCity: City){
        
        self.init(cityName: otherCity._cityName, cityCenter: otherCity._cityCenter, numOfResidents: otherCity.numOfResidents);
    }
    
    var cityName:String{
        get{
            return _cityName;
        }
        set{
            _cityName = newValue;
        }
    }
    
    var cityCenter:Point{
        get{
            return _cityCenter;
        }
        set{
            _cityCenter = cityCenter;
        }
    }
    
    var numOfResidents:Int64{
        get{
            return _numOfResidents;
        }
        set{
            if(newValue >= 0){
                _numOfResidents = newValue;
            }
        }
    }
    
    func description() -> String {
        return "City \(_cityName) has \(_numOfResidents) residents and located on \(_cityCenter.description()).";
    }
    
    func addResidents(numOfResidentsToAdd: Int64) {
        _numOfResidents += numOfResidentsToAdd;
        if(_numOfResidents < 0){
            _numOfResidents = 0;
        }
    }
    
        
    
}




















