//
//  ReminderTableViewCell.swift
//  Reminder iOS Project
//
//  Created by Alex on 14/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

var reminderRepeatStrings:[String] = ["None", "Yearly", "Monthly", "Weekly", "Daily", "Hourly"];

class ReminderTableViewCell: UITableViewCell {

    var lblTitle: UILabel!;
    var lblNote: UILabel!;
    var imgDateIcon: UIImageView!;
    var lblDate: UILabel!;
    var imgRepeatIcon: UIImageView!
    var lblRepeat: UILabel!;
    var callButton: UIButton!;
    var phoneNum: String!;
    
    static let reuseIdentifier = "Reminder";
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
                
        lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 20));
        contentView.addSubview(lblTitle);
        
        lblNote = UILabel(frame: CGRect(x: 0, y: lblTitle.frame.maxY, width: contentView.frame.width, height: 20));
        contentView.addSubview(lblNote);
        
        let imgDateIconName = UIImage(named: "date");
        imgDateIcon = UIImageView(image: imgDateIconName);
        imgDateIcon.frame = CGRect(x: 0, y: lblNote.frame.maxY, width: 20, height: 20);
        contentView.addSubview(imgDateIcon);
        
        lblDate = UILabel(frame: CGRect(x: imgDateIcon.frame.maxX, y: lblNote.frame.maxY, width: 150, height: 20));
        contentView.addSubview(lblDate);
        
        let imgRepeatIconName = UIImage(named: "repeat");
        imgRepeatIcon = UIImageView(image: imgRepeatIconName);
        imgRepeatIcon.frame = CGRect(x: lblDate.frame.maxX, y: lblNote.frame.maxY, width: 20, height: 20);
        contentView.addSubview(imgRepeatIcon);
        
        lblRepeat = UILabel(frame: CGRect(x: imgRepeatIcon.frame.maxX, y: lblNote.frame.maxY, width: 100, height: 20));
        contentView.addSubview(lblRepeat);
        
        callButton = UIButton(type: .system);
        callButton.frame = CGRect(x: contentView.frame.maxX - callButton.frame.width - 40, y: lblNote.frame.maxY, width: 30, height: 20);
        callButton.setTitle("Call", for: .normal);
        callButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside);

        contentView.addSubview(callButton);
        
    }
    
    func callNumber(sender: UIButton) {
        if let url = URL(string: "tel://\(phoneNum!)") {
            print("calling \(url)");
            UIApplication.shared.open(url, options: [:], completionHandler: nil);
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
