//
//  Grid.swift
//  GameOfLife
//
//  Created by Lia Kassardjian on 31/10/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

class Grid {
    var size: Int
    var distance: Int
    var grid: [[Cell]]
    
    init(size: Int, distance: Int) {
        self.size = size
        self.distance = distance
        
        grid = [[Cell]]()
        for i in 0..<size {
            grid.append([Cell]())
            for j in 0..<size {
                grid[i].append(Cell(x: Float(i-distance), y: Float(j-distance)))
            }
        }
    }
    
}
