//
//  User.swift
//  Lesson 07 - Username and Password HW
//
//  Created by Alex on 03/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class User {
    private var _username: String;
    private var _password:String;
    
    init(user: String, pass: String){
        _username = user;
        _password = pass;
    }
    
    
    var username: String{
        get{
            return _username;
        }
        set{
            _username = newValue;
        }
    }
    
    var password: String{
        get{
            return _password;
        }
        set{
            _password = newValue;
        }
    }
    
}