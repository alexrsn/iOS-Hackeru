//
//  ViewController.swift
//  Lesson 13 - Ball HW
//
//  Created by Alex on 24/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var ball:UIView!;
    var xPos:CGFloat = 0;
    var yPos:CGFloat = 0;
    let ballSize:CGFloat = 30;
    var xStep:CGFloat = 5;
    var yStep:CGFloat = 5;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ball = UIView(frame: CGRect(x: 0, y: 0, width: ballSize, height: ballSize));
        ball.backgroundColor = UIColor.lightGrayColor();
        ball.layer.cornerRadius = ballSize / 2;
        xPos = view.center.x;
        yPos = view.center.y;
        view.addSubview(ball);
        
        moveBall();
        
    }
    
    func moveBall() {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)/20);
        dispatch_after(popTime, dispatch_get_main_queue()) {
            if(self.ball.frame.maxY >= self.view.frame.height || self.ball.frame.minY <= 0){
                self.yPos -= self.yStep;
                self.yStep *= -1;
            }
            if(self.ball.frame.maxX >= self.view.frame.width || self.ball.frame.minX <= 0 ){
                self.xPos -= self.xStep;
                self.xStep *= -1;
            }
            self.xPos += self.xStep;
            self.yPos += self.yStep;
            self.ball.frame.origin.x = self.xPos;
            self.ball.frame.origin.y = self.yPos;
            self.moveBall();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

