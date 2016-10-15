//
//  AppDelegate.swift
//  Lesson 18 - Notification
//
//  Created by Alex on 11/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//


//
//  AppDelegate.swift
//  Lesson 18 - Notification
//
//  Created by Elad Lavi on 11/09/2016.
//  Copyright © 2016 HackerU LTD. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //let notificationName = "NotificationNameGoesHere";
    var weHavePermissionToNotifications = false;
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        //ask the user if we are allowed to perform local notifications
        let settings = UIUserNotificationSettings(forTypes: .Alert, categories: nil);
        application.registerUserNotificationSettings(settings);
        
        /*
         //sending a notification:
         let notification = NSNotification(name: notificationName, object: self, userInfo: [
         "Key1" : "Value1",
         "Key2" : "Value2"
         ]);
         NSNotificationCenter.defaultCenter().postNotification(notification);
         */
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        let key1 = notification.userInfo!["Key1"] as? String;
        let key2 = notification.userInfo!["Key2"] as? String;
        if key1 != nil {
            print("we've got a notification \(key1!) \(key2!)");
        }
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types == .None {
            weHavePermissionToNotifications = false;
            return;
        }
        let notification = UILocalNotification();
        notification.fireDate = NSDate(timeIntervalSinceNow: 8);
        notification.timeZone = NSCalendar.currentCalendar().timeZone;
        notification.alertBody = "You have a new message from Bryan";
        notification.hasAction = true;
        notification.alertAction = "View";
        notification.userInfo = [
            "Key1" : "Value1",
            "Key2" : "Value2"
        ];
        
        application.scheduleLocalNotification(notification);
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}