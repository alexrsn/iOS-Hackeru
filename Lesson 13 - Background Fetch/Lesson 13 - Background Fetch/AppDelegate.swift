//
//  AppDelegate.swift
//  Lesson 13 - Background Fetch
//
//  Created by Alex on 24/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var newsItems:[NewsItem]!
    static let newNewsItemNotification = "NewNewsItemNotification";
    var viewController: ViewController?;
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        newsItems = [NewsItem]();
        newsItems.append(NewsItem(date: NSDate(), text: "News Item 1"));
        
        return true
    }
    
    func fetchNewsItems() ->Bool{
        newsItems.append(NewsItem(date: NSDate(), text: "News Item \(newsItems.count + 1)"));
        if let theViewController = viewController{
            theViewController.hasNewNewsItem();
        }
        return true;
    }
    
    
    //this method will be invoked by the OS every number of minutes, normally, about 10 minutes but not necessarily
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        if fetchNewsItems(){
            completionHandler(.NewData);
        }else{
            completionHandler(.NoData);
        }
        
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        if let theViewController = viewController{
            theViewController.didEnterBackground();
        }
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        if let theViewController = viewController{
            theViewController.willEnterForeground();
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
