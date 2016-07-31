//
//  Canvas.swift
//  Canvas HW
//
//  Created by Alex on 24/07/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
class Canvas{
    var canvas:[[Bool]];
    let screenWidth = 50;
    let screenHeight = 50;
    
    init(){
        canvas = [[Bool]]()
        for _ in 0..<screenHeight{
            var row  = [Bool]();
            for _ in 0..<screenWidth{
                row.append(false);
            }
            canvas.append(row);
        }
    }
    
    func drawRectangle(x: Int, y: Int, width: Int, height: Int){
        for i in x..<x + width{
            canvas[y][i] = true;
            canvas[y + height - 1][i] = true;
        }
        for i in y..<y + height - 2{
            canvas[i+1][x] = true;
            canvas[i+1][x + width - 1] = true;
        }
    }
    
    func paint(){
        var line: String;
        for var i = 0;i < canvas.count; i++ {
            line = "";
            for var j = 0;j < canvas.count; j++ {
                line += (canvas[i][j] ? "* " : "  ");
            }
            print(line);
        }
    }
}
