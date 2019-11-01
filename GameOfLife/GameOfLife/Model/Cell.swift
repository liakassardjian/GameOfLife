//
//  Cell.swift
//  GameOfLife
//
//  Created by Lia Kassardjian on 31/10/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

class Cell {
    var position: (x: Int, y: Int)
    var status: CellStatus
    var aliveNeighbours: Int
    
    init(x: Int, y: Int) {
        position = (x,y)
        status = .dead
        aliveNeighbours = 0
    }
    
    func copy() -> Cell {
        let newCell = Cell(x: position.x, y: position.y)
        newCell.aliveNeighbours = aliveNeighbours
        newCell.status = status
        return newCell
    }
}

enum CellStatus {
    case alive
    case dead
}
