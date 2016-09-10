//
//  ViewController.swift
//  Lesson 16 - Playing Video
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class ViewController: UIViewController {

    var moviePlayer: AVPlayerViewController!;
    var playButton: UIButton!;
    var isPlaying = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton = UIButton(type: .System);
        playButton.frame = CGRect(x: 0, y: view.frame.height - 50, width: 300, height: 30);
        playButton.center.x = view.center.x;
        playButton.addTarget(self, action: "startPlayingVideo:", forControlEvents: .TouchUpInside);
        playButton.setTitle("play", forState: .Normal);
        view.addSubview(playButton);
        
    }
    
    func startPlayingVideo(sender: UIButton){
        if(isPlaying){
            removeVideo();
        }else{
            moviePlayer = AVPlayerViewController();
            playButton.setTitle("stop", forState: .Normal);
            let url = NSBundle.mainBundle().URLForResource("myVideo", withExtension: "mov")!;
            moviePlayer!.player = AVPlayer(URL: url);
            moviePlayer!.view.frame = CGRect(x: (view.frame.width - 300)/2, y: 50, width: 300, height: 300);
            view.addSubview(moviePlayer!.view);
            moviePlayer!.player!.play();
            isPlaying = true;
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoHasFinishedPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil);
        }
    }
    
    func videoHasFinishedPlaying(sender: NSNotification){
        removeVideo();
    }
    
    func removeVideo(){
        if moviePlayer != nil {
            moviePlayer.player!.pause();
            moviePlayer.view.removeFromSuperview();
            moviePlayer = nil;
            isPlaying = false;
            playButton.setTitle("play", forState: .Normal);
            NSNotificationCenter.defaultCenter().removeObserver(self);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

