//
//  ViewController.swift
//  Lesson 17 - Camera
//
//  Created by Alex on 10/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import MobileCoreServices


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var cameraController: UIImagePickerController!;
    var imageView: UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkingCamera();
        
        let btnShowCamera = UIButton(type: .System);
        btnShowCamera.frame = CGRect(x: 0, y: view.frame.height - 50, width: 300, height: 30);
        btnShowCamera.center.x = view.center.x;
        btnShowCamera.setTitle("show camera", forState: .Normal);
        btnShowCamera.addTarget(self, action: "btnShowCamera:", forControlEvents: .TouchUpInside);
        view.addSubview(btnShowCamera);
        
        imageView = UIImageView(frame: CGRect(x: 10, y: 30, width: view.frame.width - 10*2, height: view.frame.width));
        imageView.contentMode = .ScaleAspectFit;
        view.addSubview(imageView);
    }
    
    func btnShowCamera(sender: UIButton){
        cameraController = UIImagePickerController();
        cameraController.sourceType = .Camera;
        cameraController.mediaTypes = [kUTTypeImage as String];
        cameraController.allowsEditing = true;
        cameraController.delegate = self;
        presentViewController(cameraController, animated: true, completion: nil);
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image;
        picker.dismissViewControllerAnimated(false, completion: nil);
    }
    
    
    func checkingCamera(){
        let hasCamera:Bool = UIImagePickerController.isSourceTypeAvailable(.Camera);
        print("has camera: \(hasCamera)");
        let supportedMediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera);
        if let theSupportedMediaTypes = supportedMediaTypes{
            for type in theSupportedMediaTypes{
                print(type);
            }
        }
        let hasFront = UIImagePickerController.isCameraDeviceAvailable(.Front);
        let hasRear = UIImagePickerController.isCameraDeviceAvailable(.Rear);
        print("front: \(hasFront), rear: \(hasRear)");
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
