//
//  ViewController.swift
//  Lesson 07 - Displaying Alert Controller
//
//  Created by Alex on 03/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var alertController: UIAlertController!;
    var txtUserName : UITextField!;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        alertController = UIAlertController(title: "title", message: "message", preferredStyle: .Alert);
        let actionDone = UIAlertAction(title: "Done", style: .Default) { [weak self](action: UIAlertAction) in
            //print("done.. \(self.txtUserName!.text!)");
            let t = self!.alertController.textFields![0].text!;
            
            print("done \(t)");
            
        };
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .Destructive) { [weak self](action: UIAlertAction) in
            //print("done.. \(self.txtUserName!.text!)");
            let t = self!.alertController.textFields![0].text!;
            
            print("cancel \(t)");
            
        };
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            textField.placeholder = "username";
            self.txtUserName = textField;
            textField.secureTextEntry = true;
        }
        
        alertController.addAction(actionDone);
        alertController.addAction(actionCancel);
        */
        
        alertController = UIAlertController(title: "Choose how you would like to share this photo", message: "You cannot restore deleted photo", preferredStyle: .ActionSheet);
        
        let actionEmail = UIAlertAction(title: "via Email", style: .Default) { (action: UIAlertAction) in
            //TODO: send image over email
        }
        
        let actionWhatsapp = UIAlertAction(title: "Whatsapp", style: .Default) { (action: UIAlertAction) in
            //TODO: send image over whatsapp
        }
        
        let actionDelete = UIAlertAction(title: "Delete photo", style: .Destructive) { (action: UIAlertAction) in
            //TODO: delete photo
        }
        
        alertController.addAction(actionEmail);
        alertController.addAction(actionWhatsapp);
        alertController.addAction(actionDelete);
        
        
        
        
        
        
    }
    
    func alert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        
        let action = UIAlertAction(title: "Ok", style: .Default) { (action: UIAlertAction) in
            print("done button clicked");
        };
        alertController.addAction(action);
        presentViewController(alertController, animated: true, completion: nil);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        //alert("Title", message: "message");
        presentViewController(alertController, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

