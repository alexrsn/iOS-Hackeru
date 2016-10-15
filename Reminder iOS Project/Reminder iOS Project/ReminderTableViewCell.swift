//
//  ReminderTableViewCell.swift
//  Reminder iOS Project
//
//  Created by Alex on 14/10/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


class ReminderTableViewCell: UITableViewCell {

    var lblTitle: UILabel!;
    var lblNote: UILabel!;
    var lblDate: UILabel!;
    var lblTime: UILabel!;
    var lblRepeat: UILabel!;
    var callButton: UIButton!;
    var deleteButton: UIButton!;
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        contentView.backgroundColor = UIColor.blue;
        
        lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width / 2, height: 20));
        lblTitle.text = "Title:";
        contentView.addSubview(lblTitle);
        
        lblNote = UILabel(frame: CGRect(x: 0, y: lblTitle.frame.maxY, width: contentView.frame.width / 2, height: 20));
        lblNote.text = "Note:";
        contentView.addSubview(lblNote);
        
        lblDate = UILabel(frame: CGRect(x: 0, y: lblNote.frame.maxY, width: 60, height: 20));
        lblDate.text = "Date:";
        contentView.addSubview(lblDate);
        
        lblTime = UILabel(frame: CGRect(x: lblDate.frame.maxX, y: lblNote.frame.maxY, width: 60, height: 20));
        lblTime.text = "Time:";
        contentView.addSubview(lblTime);
        
        lblRepeat = UILabel(frame: CGRect(x: lblTime.frame.maxX, y: lblNote.frame.maxY, width: 60, height: 20));
        lblRepeat.text = "Repeat:";
        contentView.addSubview(lblRepeat);
                
        
        //        contentView.addSubview(callButton);
        //        contentView.addSubview(deleteButton);

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
