//
//  ViewController.swift
//  Lesson 10 - Dynamic Views
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //1. gravity UIGravityBehavior
    //2. collision UICollisionBehavior (UICollisionBehaviorDelegate)
    //3. push
    
    
    var squareView: UIView!;
    //var squareViews: [UIView]!;
    var animator: UIDynamicAnimator!;
    //let bottomBoundry = "bottomBoundry"
    var pushBehavior: UIPushBehavior!;
    var snapBehavior: UISnapBehavior!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        
        //snap
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80));
        squareView.backgroundColor = UIColor.green;
        squareView.center = view.center;
        view.addSubview(squareView);
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)));
        view.addGestureRecognizer(tapGestureRecognizer);
        animator = UIDynamicAnimator(referenceView: view);
        let collision = UICollisionBehavior(items: [squareView]);
        collision.translatesReferenceBoundsIntoBoundary = true;
        animator.addBehavior(collision);
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: view.center);
        animator.addBehavior(snapBehavior);
        

        
        /*
        //push
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80));
        squareView.backgroundColor = UIColor.greenColor();
        squareView.center = view.center;
        view.addSubview(squareView);
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:");
        view.addGestureRecognizer(tapGestureRecognizer);
        animator = UIDynamicAnimator(referenceView: view);
        let collision = UICollisionBehavior(items: [squareView]);
        collision.translatesReferenceBoundsIntoBoundary = true;
        animator.addBehavior(collision);
        pushBehavior = UIPushBehavior(items: [squareView], mode: .Continuous);
        animator.addBehavior(pushBehavior);
        */
        
        
        /* 
         //gravity and collision
        squareViews = [UIView]();
        let colors = [UIColor.blueColor(),UIColor.redColor(),UIColor.greenColor()];
        var yPos = 10;
        let squareSize = 50;
        for var i=0;i<3;i++ {
            let squareView = UIView(frame: CGRect(x: 150 + i * 20, y: yPos, width: squareSize, height: squareSize));
            yPos += squareSize + 2;
            squareView.backgroundColor = colors[i%colors.count];
            //squareView.center.x = view.center.x;
            squareViews.append(squareView);
            view.addSubview(squareView);
        }
        
        
        animator = UIDynamicAnimator(referenceView: view);
        let gravity = UIGravityBehavior(items: squareViews);
        animator.addBehavior(gravity);
        let collision = UICollisionBehavior(items: squareViews);
        collision.translatesReferenceBoundsIntoBoundary = true;
        
        let fromPoint = CGPoint(x: 20, y: 300);
        let toPoint = CGPoint(x: 250, y: 200);
        collision.addBoundaryWithIdentifier(bottomBoundry, fromPoint: fromPoint, toPoint: toPoint);
        collision.collisionDelegate = self;
        animator.addBehavior(collision);
        */
        
    }
    
    /*
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        if  let theIdentifier = identifier as? String{
            if theIdentifier == bottomBoundry {
                UIView.animateWithDuration(1, animations: { 
                    let v = item as! UIView;
                    //v.alpha = 0;
                    v.transform = CGAffineTransformMakeScale(2, 2);
                    }, completion: { (finished: Bool) in
                        let v = item as! UIView;
                        v.removeFromSuperview();
                        behavior.removeItem(item);
                });
            }
        }
    }
    */
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        //snap
        let tapPoint = sender.location(in: view);
        animator.removeBehavior(snapBehavior);
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint);
        snapBehavior.damping = 0.5;
        animator.addBehavior(snapBehavior);
        
        /*
        //push
        let tapPoint = sender.locationInView(view);
        let deltaX = tapPoint.x - squareView.center.x;
        let deltaY = tapPoint.y - squareView.center.y;
        let angle = atan2(deltaY, deltaX);
        pushBehavior.angle = angle;
        let distance = sqrt(deltaX * deltaX + deltaY * deltaY);
        pushBehavior.magnitude = distance / 200.0;
        */
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}










