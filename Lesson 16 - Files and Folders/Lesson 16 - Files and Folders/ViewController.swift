//
//  ViewController.swift
//  Lesson 16 - Files and Folders
//
//  Created by Alex on 04/09/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit


extension NSURL{
    func isDirectory()->Bool?{
        var value: AnyObject?;
        do{
            try self.getResourceValue(&value, forKey: NSURLIsDirectoryKey);
            if value != nil {
                let number = value as! NSNumber;
                return number.boolValue;
            }
        }catch{
            
        }
        return nil;
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let urls = NSFileManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask);//these folders are inside our app directory. They cannot be accesses neither by other app nor by the user.
        //print(urls[0]);
        let tempDirectory = NSTemporaryDirectory();
        print(tempDirectory);
        
        //let destinationPath = tempDirectory + "MyFile.txt";
        
        //let someText = NSString(string: "nadav politi and Saimon the king");
        /*
         //NSString:
         
         do{
         try someText.writeToFile(destinationPath, atomically: true, encoding: NSUTF8StringEncoding);
         let readString = try NSString(contentsOfFile: destinationPath, encoding: NSUTF8StringEncoding);
         print(readString);
         }catch{
         
         }
         */
        
        
        /*
         //NSArray:
         let arrayOfNams:NSArray = ["Nadav", "Sela", "Zhanna"];
         arrayOfNams.writeToFile(destinationPath, atomically: true);
         let readArray = NSArray(contentsOfFile: destinationPath);
         if let arr = readArray{
         for var i=0; i<arr.count; i++ {
         print(arr[i]);
         }
         }
         */
        
        /*
         //NSDictionary:
         let dict:NSDictionary = [
         "first name" : "Steven",
         "last name" : "Paul",
         "age" : 45
         ];
         dict.writeToFile(destinationPath, atomically: true);
         let readDict = NSDictionary(contentsOfFile: destinationPath);
         if let theDict = readDict{
         print(theDict["first name"] as! String);
         print(theDict["last name"] as! String);
         print("\((theDict["age"] as! Int)+1)");
         }
         */
        
        /*
         //NSData
         let data = NSMutableData();
         //let bytes:[Int8] = [50, 51, 52, 53];
         //data.appendBytes(bytes, length: bytes.count)
         var x:Int = 127;
         data.appendBytes(&x, length: 4);
         data.writeToFile(destinationPath, atomically: true);
         let readData = NSData(contentsOfFile: destinationPath);
         let bytesRead = readData!.bytes as! [Int8];
         print(bytesRead);
         */
        /*
         let someTextData = someText.dataUsingEncoding(NSUTF8StringEncoding)!;
         var buffer:[UInt8] = [UInt8](count: someTextData.length, repeatedValue: 0);
         //for var i=0; i<someTextData.length; i++ {
         //    buffer.append(0);
         //}
         someTextData.getBytes(&buffer, length: buffer.count);
         for var i=0; i<buffer.count; i++ {
         print(buffer[i]);
         }
         print(ViewController.bytesToString(&buffer, offset: 0, length: buffer.count));
         */
        
        
        //NSString, NSDictionary, NSArray, NSData, NSNumber, NSDate
        
        /*
         //creating folders:
         //let imagesPath = (tempDirectory as! NSString).stringByAppendingPathComponent("images");
         let imagesPath = tempDirectory + "images/";
         do{
         try NSFileManager().createDirectoryAtPath(imagesPath, withIntermediateDirectories: true, attributes: nil);
         print("created");
         }catch{
         print("failed to create directory");
         }
         */
        
        /*
         let propertiesToGet = [
         NSURLIsDirectoryKey,
         NSURLIsReadableKey,
         NSURLCreationDateKey,
         NSURLContentAccessDateKey,
         NSURLContentModificationDateKey
         ]
         
         do{
         /*
         let contents = try NSFileManager().contentsOfDirectoryAtPath(tempDirectory);
         for path in contents{
         print(path);
         }
         */
         let contents = try NSFileManager().contentsOfDirectoryAtURL(NSURL(string: tempDirectory)!, includingPropertiesForKeys: propertiesToGet, options: .SkipsSubdirectoryDescendants);
         for url in contents{
         print("\(url.lastPathComponent!) is directory \(url.isDirectory()!)");
         
         }
         
         }catch{
         print("error");
         }
         */
        
        /*
         //deleting:
         do{
         try NSFileManager().removeItemAtPath(tempDirectory + "images/");
         print("deleted");
         }catch{
         print("error");
         }
         */
        
        //let p1 = Person(firstName: "Nadav", lastName: "Politi");
        //NSKeyedArchiver.archiveRootObject(p1, toFile: tempDirectory + "nadav.txt");
        /*
         let p2 = NSKeyedUnarchiver.unarchiveObjectWithFile(tempDirectory + "nadav.txt") as! Person;
         print("\(p2.firstName) \(p2.lastName)");
         let p3 = Person(firstName: "Yan", lastName: "Barzilai");
         let personArray: NSArray = ["one", "two"];
         if personArray.writeToFile(tempDirectory + "persons.txt", atomically: true){
         print("success");
         }else{
         print("error");
         }
         */
        let p1 = Person(firstName: "Nadav", lastName: "Politi");
        p1.toNSData().writeToFile(tempDirectory + "nadav.dat", atomically: true);
        let p2 = Person(data: NSData(contentsOfFile: tempDirectory + "nadav.dat")!);
        print(p2.firstName);
        print(p2.lastName);
    }
    
    
    
    static func bytesToString(inout bytes:[UInt8], offset: Int, length: Int) -> NSString{
        if offset == 0{
            return NSString(bytes: bytes, length: length, encoding: NSUTF8StringEncoding)!;
        }else{
            var temp: [UInt8] = [UInt8]();
            let to = offset + length;
            for var i=offset; i<to; i++ {
                temp.append(bytes[i]);
            }
            return NSString(bytes: temp, length: temp.count, encoding: NSUTF8StringEncoding)!;
        }
    }
    
    
    static func bytesToInt32(inout bytes:[UInt8], offset: Int)->Int {
        var result:Int = 0;
        for var i=0; i<4; i++ {
            result += Int(bytes[offset + i]) << Int((4-1-i)*8);
        }
        return result;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}