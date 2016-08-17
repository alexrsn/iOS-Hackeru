//
//  MyProgressView.swift
//  Lesson 10 - Progress View
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class MyProgressView: UIView{
    
    private var _progress:CGFloat = 0;
    
    private var progressView:UIView;
    
    override init(frame: CGRect) {
        progressView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: frame.height));
        super.init(frame: frame);
        backgroundColor = UIColor.grayColor();
        progressView.backgroundColor = UIColor.blueColor();
        self.addSubview(progressView);
    }
    
    //we have this only because of a defect in swift  initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError("do not use this initializer");
    }
    
    var progress:CGFloat{
        get{
            return _progress;
        }
        set{
            if newValue > 1{
                _progress = 1;
            }else if newValue < 0{
                _progress = 0;
            }else{
                _progress = newValue;
            }
            progressView.frame = CGRect(x: 0, y: 0, width: frame.width * _progress, height: frame.height);
        }
    }
    
    var baseColor:UIColor?{
        get{
            return backgroundColor;
        }
        set{
            backgroundColor = newValue;
        }
    }
    
    var progressColor:UIColor?{
        get{
            return progressView.backgroundColor;
        }
        set{
            progressView.backgroundColor = newValue;
        }
    }
    
    
    
    
}

















