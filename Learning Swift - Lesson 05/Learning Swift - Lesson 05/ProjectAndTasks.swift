//
//  ProjectAndTasks.swift
//  Learning Swift - Lesson 05
//
//  Created by Alex on 27/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation

class Project: TaskCompletedDelegate{
    var name = "";
    var listOfTasks = [Task]();
    var completedCounter = 0;
    func projectCompleted() {
        print("project \(self.name) is completed.");
    }
    func taskCompleted(task: Task){
        completedCounter++;
        if(completedCounter == listOfTasks.count){
            projectCompleted();
        }
    }
}

class Task{
    var delegate : TaskCompletedDelegate?;
    var name = "";
    private var _done = false;
    
    func done(){
        _done = true;
        if let theDelegate = delegate{
            theDelegate.taskCompleted(self);
            delegate = nil;
        }
    }
}

protocol TaskCompletedDelegate {
    func taskCompleted(task: Task);
}

