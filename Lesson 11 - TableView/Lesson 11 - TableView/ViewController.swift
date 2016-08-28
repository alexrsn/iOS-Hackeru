//
//  ViewController.swift
//  Lesson 11 - TableView
//
//  Created by Alex on 17/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var tableView:UITableView!;
    let identifier = "identifier";
    
    var data = [["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"],["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"],["1","2","3","4","5","6","7","8","9","10"],];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView = UITableView(frame: view.frame, style: .Grouped);
        
        //register for re-use
        //tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier);
        tableView.dataSource = self;
        tableView.delegate = self;
        view.addSubview(tableView);
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        switch section {
        case 0:
            return 20;
        case 1:
            return 30;
        default:
            return 0
        }
        */
        return data[section].count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath);
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier);
        
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier);
            let imageView = UIImageView(frame: CGRect(x: cell!.contentView.frame.width - 20 - 5, y: 0, width: 20, height: 20));
            cell!.contentView.addSubview(imageView);
        }
        //cell.textLabel?.text = "Section \(indexPath.section + 1) Row \(indexPath.row + 1)";
        cell!.textLabel?.text = "\(data[indexPath.section][indexPath.row])";
        let imageView = cell!.contentView.subviews[0] as! UIImageView;
        
        return cell!;    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete;
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            //delete the row
            data[indexPath.section].removeAtIndex(indexPath.row);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left);
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return newLabelWithTitle("Section \(section + 1) header");
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return newLabelWithTitle("Section \(section + 1) footer");
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func newLabelWithTitle(title: String) -> UILabel {
        let label = UILabel();
        label.text = title;
        label.backgroundColor = UIColor.clearColor();
        label.sizeToFit();
        return label;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

