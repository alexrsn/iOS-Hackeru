//
//  ViewController.swift
//  Lesson 16 - Playing Audio Files
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer!;
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finished playing");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue) { 
            let filePath = NSBundle.mainBundle().pathForResource("123", ofType: "mp3")!;
            let fileData = NSData(contentsOfFile: filePath);
            do{
                self.audioPlayer = try AVAudioPlayer(data: fileData!);
                self.audioPlayer.delegate = self;
                if self.audioPlayer.prepareToPlay() && self.audioPlayer.play(){
                    print("now playing");
                }
                
                
            }catch{
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

