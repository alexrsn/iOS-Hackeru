//
//  ViewController.swift
//  Lessonn 11 - Users TableView HW
//
//  Created by Alex on 17/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var addButton: UIButton!;
    var usersTable: UITableView!;
    var alertController: UIAlertController!;
    
    var users:[User] = [User]();
    let identifier = "UserCell";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton = UIButton(type: .System);
        addButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30);
        addButton.center.x = view.center.x;
        addButton.setTitle("Add User", forState: .Normal);
        addButton.addTarget(self, action: "addUserClicked:", forControlEvents: .TouchUpInside);
        view.addSubview(addButton);
        
        users.append(User(firstName: "Alex", lastName: "Resin", photo: UIImage(named: "pic1")!));
        users.append(User(firstName: "Moshe", lastName: "asd", photo: UIImage(named: "pic2")!));
        
        usersTable = UITableView(frame: CGRect(x: 0, y: addButton.frame.maxY + 5, width: view.frame.width, height: view.frame.height - addButton.frame.height - 5), style: .Plain);
        usersTable.dataSource = self;
        usersTable.delegate = self;
        view.addSubview(usersTable);
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count;
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            users.removeAtIndex(indexPath.row);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left);
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        alertController = UIAlertController(title: "Edit user", message: "", preferredStyle: .Alert);
        
        let actionSave = UIAlertAction(title: "Save", style: .Default) {[weak self](action: UIAlertAction) in
            self!.users[indexPath.row].firstName = self!.alertController.textFields![0].text!;
            self!.users[indexPath.row].lastName = self!.alertController.textFields![1].text!;
            self!.usersTable.reloadData();
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil);
        alertController.addTextFieldWithConfigurationHandler { (firstName: UITextField) in
            firstName.placeholder = "First Name";
            firstName.text = self.users[indexPath.row].firstName;
        }
                alertController.addTextFieldWithConfigurationHandler { (lastName: UITextField) in
            lastName.placeholder = "Last Name";
            lastName.text = self.users[indexPath.row].lastName;
        }
        alertController.addAction(actionCancel);
        alertController.addAction(actionSave);
        
        presentViewController(alertController, animated: true, completion: nil);
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier);
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier);
            let imageView = UIImageView(frame: CGRect(x: cell!.contentView.frame.width - 20 - 5, y: 0, width: 10, height: cell!.contentView.frame.height));
            imageView.contentMode = .ScaleAspectFill;
            cell!.contentView.addSubview(imageView);
        }
        cell!.textLabel?.text = "\(users[indexPath.row].firstName) \(users[indexPath.row].lastName)";
        let imageView = cell!.contentView.subviews[0] as! UIImageView;
        imageView.image = users[indexPath.row].photo;
        return cell!;
    }
    
   
    func addUserClicked(sender: UIButton) {
        alertController = UIAlertController(title: "Add new user", message: "", preferredStyle: .Alert);
        
        let actionSave = UIAlertAction(title: "Save", style: .Default) {[weak self](action: UIAlertAction) in
            self!.users.append(User(firstName: "\(self!.alertController.textFields![0].text!)", lastName: "\(self!.alertController.textFields![1].text!)", photo: UIImage(named: "pic\(self!.users.count % 3 + 1)")!));
            self!.usersTable.reloadData();
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil);
        alertController.addTextFieldWithConfigurationHandler { (firstName: UITextField) in
            firstName.placeholder = "First Name";
        }
        
        alertController.addTextFieldWithConfigurationHandler { (lastName: UITextField) in
            lastName.placeholder = "Last Name";
        }
        alertController.addAction(actionCancel);
        alertController.addAction(actionSave);

        presentViewController(alertController, animated: true, completion: nil);
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
























