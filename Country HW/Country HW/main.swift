//
//  main.swift
//  Country HW
//
//  Created by Alex on 30/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

var city1 = City(cityName: "Ashdod", cityCenter: Point(x: 2,y: 3), numOfResidents: 300000);
var city2 = City(cityName: "Rishon", cityCenter: Point(x: 4,y: 5), numOfResidents: 3445);
var city3 = City(cityName: "Eilat", cityCenter: Point(x: 2,y: 3), numOfResidents: 30456);
var city4 = City(cityName: "Ashkelon", cityCenter: Point(x: 3,y: 2), numOfResidents: 303);
var city5 = City(cityName: "Rehovot", cityCenter: Point(x: 1,y: 1), numOfResidents: 30675);
var city6 = City(cityName: "Tel Aviv", cityCenter: Point(x: 4,y: 5), numOfResidents: 54630);
var city7 = City(cityName: "Dimona", cityCenter: Point(x: 3,y: 8), numOfResidents: 78730);
var city8 = City(cityName: "Yavne", cityCenter: Point(x: 2,y: 1), numOfResidents: 98030);
var city9 = City(cityName: "Bat Yam", cityCenter: Point(x: 8,y: 3), numOfResidents: 430);


var country = Country(countryName: "Israel");

country.cities.append(city1);
country.cities.append(city2);
country.cities.append(city3);
country.cities.append(city4);
country.cities.append(city5);
country.cities.append(city6);
country.cities.append(city7);
country.cities.append(city8);
country.cities.append(city9);

let temp = country.citiesNorthOf("Yavne");
for city in temp{
    print(city.description());
}

print("Longest distance in country: \(country.longestDistance())");

print("Number of residents in country: \(country.getNumOfResidents())");










