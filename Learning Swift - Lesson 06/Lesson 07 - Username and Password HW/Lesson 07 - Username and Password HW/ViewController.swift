//
//  ViewController.swift
//  Lesson 07 - Username and Password HW
//
//  Created by Alex on 03/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var alertController: UIAlertController!;
    var userName: UITextField!;
    var password: UITextField!;
    var users: [User]!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = [User]();
        users.append(User(user: "jhgjg", pass: "1234"));
        users.append(User(user: "asd", pass: "3241"));
        users.append(User(user: "234", pass: "2345"));
        users.append(User(user: "alex", pass: "4321"));
        users.append(User(user: "gfdg", pass: "6575"));
        
        var loginButton: UIButton = UIButton(type: .System);
        loginButton.frame = CGRect(x: 0, y: 0, width: 100, height: 50);
        loginButton.setTitle("login", forState: .Normal);
        loginButton.addTarget(self, action: "loginClicked:", forControlEvents: .TouchUpInside);
        loginButton.center = view.center;
        
        view.addSubview(loginButton)
        
        /*
        alertController = UIAlertController(title: "Login", message: "Enter username and password", preferredStyle: .Alert);
        let actionLogin: UIAlertAction = UIAlertAction(title: "Login", style: .Default) { (action:  UIAlertAction) in
            var found: Bool = false;
            for user in self.users{
                if(user.username == self.userName.text && user.password == self.password.text){
                    self.alert("User \(self.userName.text!) logged in");
                    found = true;
                    break;
                }
            }
            if(!found){
                self.alert("Wrong username or password");
            }
        }
        
        alertController.addTextFieldWithConfigurationHandler { (userName: UITextField) in
            userName.placeholder = "username";
            self.userName = userName;
        }
        
        alertController.addTextFieldWithConfigurationHandler { (password: UITextField) in
            password.placeholder = "password";
            password.secureTextEntry = true;
            self.password = password;
        }
        
        alertController.addAction(actionLogin);
        */
        
        alertController = UIAlertController(title: "Login", message: "Enter username", preferredStyle: .Alert);
        
        let actionUserLogin: UIAlertAction = UIAlertAction(title: "Next", style: .Default) { (action:  UIAlertAction) in
            var found: Bool = false;
            for user in self.users{
                if(user.username == self.userName.text){
                    found = true;
                    self.checkPassword(user.password);
                    break;
                }
            }
            if(!found){
                self.alert("Wrong username");
            }
        }
        
        let actionCancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
        
        alertController.addTextFieldWithConfigurationHandler { (userName: UITextField) in
            userName.placeholder = "username";
            self.userName = userName;
        }
        
        
        alertController.addAction(actionUserLogin);
        alertController.addAction(actionCancel);
        
        
        
        
        
    }
    
    func loginClicked(sender: UIButton){
        presentViewController(alertController, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(message: String){
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .Alert);
        
        let action = UIAlertAction(title: "Ok", style: .Default) { (action: UIAlertAction) in };
        alertController.addAction(action);
        presentViewController(alertController, animated: true, completion: nil);
    }

    
    func checkPassword(choosedUserPassword: String){
        let passAlertController: UIAlertController = UIAlertController(title: "Enter password", message: "", preferredStyle: .Alert);
        
        passAlertController.addTextFieldWithConfigurationHandler { (password: UITextField) in
            password.placeholder = "password";
            password.secureTextEntry = true;
            self.password = password;
        }
        
        let actionPassLogin: UIAlertAction = UIAlertAction(title: "Login", style: .Default, handler: { (action: UIAlertAction) in
            if(choosedUserPassword == self.password.text){
                self.alert("User \(self.userName.text!) logged in");
            }else{
                self.alert("Wrong password!!!");
            }
        });
        
        let actionCancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
        
        passAlertController.addAction(actionPassLogin);
        passAlertController.addAction(actionCancel);
        presentViewController(passAlertController, animated: true, completion: nil);
    }

}

