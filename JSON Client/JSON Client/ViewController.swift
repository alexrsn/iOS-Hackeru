//
//  ViewController.swift
//  JSON Client
//
//  Created by Alex on 05/11/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var txtMessageFromServer: UITextView!;
    var btnSendJSON: UIButton!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtMessageFromServer = UITextView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 300));
        txtMessageFromServer.backgroundColor = UIColor.gray;
        view.addSubview(txtMessageFromServer);
        
        btnSendJSON = UIButton(type: .system);
        btnSendJSON.frame = CGRect(x: 0, y: txtMessageFromServer.frame.maxY + 5, width: view.frame.width, height: 30);
        btnSendJSON.setTitle("Send JSON", for: .normal);
        btnSendJSON.addTarget(self, action:  #selector(btnSendJSONClicked), for: .touchUpInside);
        view.addSubview(btnSendJSON);
        var dict : [String: String] = [
            "firstName" : "John",
            "lastName" : "Smith"
        ];
        do{
            let d = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted);
            
            let urlRequest = NSMutableURLRequest(url: URL(string: baseUrl)!);
            
            urlRequest.httpMethod = "POST";
            let task = session.uploadTask(with: urlRequest as URLRequest, from: d, completionHandler: { [weak self](data: Data?, response: URLResponse?, error: Error?) in
                DispatchQueue.main.async {
                    [weak self] in
                    self!.btnSend.isEnabled = true;
                    self!.txtMessage.isEnabled = true;
                    self!.btnSend.setTitle("send", for: .normal);
                }
                if error == nil{
                    if let theData = data{
                        if theData.count > 0{
                            do{
                                let jsonResponse = try JSONSerialization.jsonObject(with: theData, options: .allowFragments) as! [String: String];
                                let result = jsonResponse["result"];
                                print("message sent: \(result)");
                                DispatchQueue.main.async {
                                    [weak self] in
                                    if result == "success"{
                                        self!.txtMessage.text = "";
                                        self!.lblStatus.text = "sent..";
                                        self!.lblStatus.textColor = UIColor.green;
                                        self!.friend.messages.append(Message(text: message, sender: self!.userName, recipient: self!.friend.userName));
                                        self!.tblMessages.reloadData();
                                    }else{
                                        self!.lblStatus.text = "error sending";
                                        self!.lblStatus.textColor = UIColor.red;
                                        
                                    }
                                }
                            }catch{
                                
                            }
                        }
                    }
                }
                
                });
            task.start();
            
            
        }catch{
            print("error");
        }
        
        
    }
    
    func btnSendJSONClicked(sender: UIButton) {
        print("asd");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

