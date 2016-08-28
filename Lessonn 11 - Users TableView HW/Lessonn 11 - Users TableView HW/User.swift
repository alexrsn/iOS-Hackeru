//
//  User.swift
//  Lessonn 11 - Users TableView HW
//
//  Created by Alex on 17/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


class User {
    
    private var _firstName: String;
    private var _lastName: String;
    private var _photo: UIImage;
    
    init(firstName: String, lastName: String, photo: UIImage){
        _firstName = firstName;
        _lastName = lastName;
        _photo = photo;
    }
    
    var firstName:String{
        get{
            return _firstName;
        }
        set{
            _firstName = newValue;
        }
    }
    
    var lastName:String{
        get{
            return _lastName;
        }
        set{
            _lastName = newValue;
        }
    }
    
    
    var photo:UIImage{
        get{
            return _photo;
        }
        set{
            _photo = newValue
        }
    }
    
}


























