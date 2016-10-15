//
//  AppDelegate.swift
//  Lesson 18 - Receiving Notification
//
//  Created by Alex on 11/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let notificationName = "NotificationNameGoesHere";
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid;
    var notificationReceived = false;
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //listening to notifications:
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNotification:", name: notificationName, object: nil);
        
        
        return true
    }
    
    func handleNotification(notification: NSNotification){
        print("notification received with values:");
        let userInfo = notification.userInfo as! [String: String];
        print("Key1 : \(userInfo["Key1"])");
        print("Key2 : \(userInfo["Key2"])");
        notificationReceived = true;
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        backgroundTaskIdentifier = application.beginBackgroundTaskWithName("task1", expirationHandler: {
            [weak self] in
            self!.endBackgroundTask();
            });
    }
    
    func endBackgroundTask(){
        UIApplication.sharedApplication().endBackgroundTask(backgroundTaskIdentifier);
        self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        endBackgroundTask();
        print("notification received: \(notificationReceived)");
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
}
