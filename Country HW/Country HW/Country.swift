//
//  Country.swift
//  Country HW
//
//  Created by Alex on 30/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class Country {
    private var _countryName: String;
    var cities: [City];
    
    init(countryName: String){
        _countryName = countryName;
        cities = [City]();
    }
    
    var countryName:String{
        get{
            return _countryName;
        }
        set{
            _countryName = newValue;
        }
    }
    
    func getNumOfResidents() -> Int64 {
        var numOfResidents:Int64 = 0;
        for city in cities{
            numOfResidents += city.numOfResidents;
        }
        return numOfResidents;
    }
    
    func longestDistance() -> Double {
        var longestDistance:Double = 0;
        var distance: Double;
        for (var i = 0;i < cities.count - 1;i++){
            for (var j = i+1;j<cities.count;j++){
                distance = cities[i].cityCenter.distance(cities[j].cityCenter);
                if(longestDistance < distance){
                    longestDistance = distance;
                }
            }
        }
        return longestDistance;
    }
    
    func citiesNorthOf(cityName: String) -> [City] {
        var northCities:[City] = [City]();
        var cityCenter:Point?;
        for city in cities{
            if (city.cityName == cityName){
                cityCenter = city.cityCenter;
                break;
            }
        }
        if let theCityCenter = cityCenter {
            for city in cities{
                if (city.cityCenter.isAbove(theCityCenter)) {
                    northCities.append(city);
	                }
            }
        }
        return northCities;
    }
}






















