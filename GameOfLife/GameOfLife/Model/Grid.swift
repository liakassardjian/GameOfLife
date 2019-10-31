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
                grid[i].append(Cell(x: i, y: j))
            }
        }
    }
    
    func countAliveNeighbours(cell: Cell) {
        var i = cell.position.x - 1
        var j = cell.position.y - 1
        var aliveNeighbours = 0
        
        while i <= cell.position.x + 1 {
            while j <= cell.position.y + 1 {
                if i != cell.position.x, j != cell.position.y {
                    if grid[i][j].status == .alive {
                        aliveNeighbours += 1
                    }
                }
                j += 1
            }
            i += 1
        }
        cell.aliveNeighbours = aliveNeighbours
    }
    
}
