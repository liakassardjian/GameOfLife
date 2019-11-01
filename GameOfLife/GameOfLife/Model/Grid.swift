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
    var rules: [Rule]
    
    init(size: Int, distance: Int) {
        self.size = size
        self.distance = distance
        self.rules = []
        
        grid = [[Cell]]()
        for i in 0..<size {
            grid.append([Cell]())
            for j in 0..<size {
                grid[i].append(Cell(x: i, y: j))
            }
        }
        
        addRules()
    }
    
    func countAliveNeighbours(cell: Cell) {
        var i = cell.position.x - 1
        var aliveNeighbours = 0
        
        while i <= cell.position.x + 1 {
            var j = cell.position.y - 1
            
            while j <= cell.position.y + 1 {
                if !(i == cell.position.x && j == cell.position.y),
                    i >= 0 && i < size,
                    j >= 0 && j < size {
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
    
    func addRules() {
        rules.append(Rule(initialStatus: .alive, finalStatus: .dead, minValue: 0, maxValue: 1))
        rules.append(Rule(initialStatus: .alive, finalStatus: .dead, minValue: 4, maxValue: 8))
        rules.append(Rule(initialStatus: .alive, finalStatus: .alive, minValue: 2, maxValue: 3))
        rules.append(Rule(initialStatus: .dead, finalStatus: .alive, minValue: 3, maxValue: 3))
    }
    
    func updateGrid() {
        var newGrid = [[Cell]]()
        
        for i in 0..<size {
            newGrid.append([Cell]())
            for j in 0..<size {
                let cell = grid[i][j]
                countAliveNeighbours(cell: cell)
                
                let newCell = cell.copy()

                for rule in rules {
                    rule.applyRule(cell: newCell)
                }
                
                newGrid[i].append(newCell)
            }
        }
        grid = newGrid
    }
    
    func printGrid() {
        for i in 0..<size {
            for j in 0..<size {
                if grid[i][j].status == .alive {
                    print("1", separator: "", terminator: " ")
                } else {
                    print("0", separator: "", terminator: " ")
                }
            }
            print("")
        }
    }
    
}
