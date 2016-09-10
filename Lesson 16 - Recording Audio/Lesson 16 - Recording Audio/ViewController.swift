//
//  ViewController.swift
//  Lesson 16 - Recording Audio
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate,AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!;
    var audioPlayer: AVAudioPlayer!;
    
    var btnStart: UIButton!;
    var isRecording = false;
    var hasPermission = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnStart = UIButton(type: .System);
        btnStart.frame = CGRect(x: 0, y: 0, width: 300, height: 30);
        btnStart.center = view.center;
        btnStart.setTitle("Record", forState: .Normal);
        btnStart.addTarget(self, action: "btnStart:", forControlEvents: .TouchUpInside);
        view.addSubview(btnStart);
        
        let session = AVAudioSession.sharedInstance();
        do{
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .DuckOthers);
            try session.setActive(true);
            session.requestRecordPermission({ (allowed: Bool) in
                if allowed{
                    self.hasPermission = true;
                }else{
                    self.hasPermission = false;
                    print("we don't have permission ")
                }
            })
        }catch{
            
        }
        
    }
    
    func btnStart(sender: UIButton) {
        if isRecording{
            stopRecording();
            btnStart.setTitle("Record", forState: .Normal);
        }else{
            if(hasPermission){
                startRecordingAudio();
                btnStart.setTitle("Stop", forState: .Normal);
            }
        }
    }
    
    func startRecordingAudio(){
        do{
            let documentsFolderUrl = try NSFileManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false);
            let audioRecordingUrl = documentsFolderUrl.URLByAppendingPathComponent("recording.m4v");
            let settings = [AVFormatIDKey : Int(kAudioFormatMPEG4AAC) as! NSNumber,
                            AVSampleRateKey : 16000.0 as! NSNumber,
                            AVNumberOfChannelsKey: 1 as! NSNumber,
                            AVEncoderAudioQualityKey: AVAudioQuality.Low.rawValue as! NSNumber
            ];
            audioRecorder = try AVAudioRecorder(URL: audioRecordingUrl, settings: settings);
            audioRecorder.delegate = self;
            if audioRecorder.prepareToRecord() && audioRecorder.record(){
                print("now recording");
                print("\(audioRecordingUrl)");
                isRecording = true;
            }
            
        }catch{
            
        }
        
    }
    
    func stopRecording(){
        audioRecorder.stop();
        print("stopped recording");
        isRecording = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

















