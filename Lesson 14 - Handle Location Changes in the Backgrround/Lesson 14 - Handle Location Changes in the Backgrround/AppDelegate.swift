//
//  AppDelegate.swift
//  Lesson 14 - Handle Location Changes in the Backgrround
//
//  Created by Alex on 28/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager:CLLocationManager!;
    var isInBackround = false;
    var viewController:ViewController?;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        locationManager = CLLocationManager();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.startUpdatingLocation();

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        isInBackround = true;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    }

    func applicationWillEnterForeground(application: UIApplication) {
        isInBackround = false;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if isInBackround {
            //we are in the background. don't do heavy stuff.
        }else{
            //we are in the foreground, go wild and do any processing of the user's location
        }
        if let theViewController = viewController {
            theViewController.locationChanged(newLocation.coordinate.latitude as! Double,long: newLocation.coordinate.longitude as! Double);
        }
        print("latitude:\(newLocation.coordinate.latitude) longitude:\(newLocation.coordinate.longitude)");
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

