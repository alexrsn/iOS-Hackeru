//
//  AppDelegate.swift
//  Lesson 14 - Playing Audio in the Background
//
//  Created by Alex on 28/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var audioPlayer: AVAudioPlayer!;


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(queue) { [weak self] in
            let audioSession = AVAudioSession.sharedInstance();
            NSNotificationCenter.defaultCenter().addObserver(self!, selector: "handleInterruption:", name: AVAudioSessionInterruptionNotification, object: nil);
            do{
                try audioSession.setActive(true);
                try audioSession.setCategory(AVAudioSessionCategoryPlayback);
                let filePath = NSBundle.mainBundle().pathForResource("123", ofType: "mp3");
                let fileData = try NSData(contentsOfFile: filePath!, options: .DataReadingMappedIfSafe);
                try self!.audioPlayer = AVAudioPlayer(data: fileData);
                if self!.audioPlayer.prepareToPlay() && self!.audioPlayer.play(){
                    print("playing audio");
                }
            }catch{
                print("error: couldn't set as active");
            }
        }
        return true
    }

    func stopPlaying() {
        audioPlayer.stop();
    }
    
    func handleInterruption(notification: NSNotification) {
        //this will be invoked when thre is an interruption
        print("handleInterruption");
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
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }


}

