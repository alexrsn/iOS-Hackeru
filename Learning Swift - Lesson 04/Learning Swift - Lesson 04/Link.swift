//
//  Link.swift
//  Learning Swift - Lesson 04
//
//  Created by Alex on 24/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class Link {
    var value: String;
    var next: Link?;
    
    init(value: String){
        self.value = value;
    }
}