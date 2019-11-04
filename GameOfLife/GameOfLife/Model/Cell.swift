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
    var aliveNeighbours: Int
    var geometry: Int
    var neighboursGeometry: Int
    var status: CellStatus
    
    init(x: Int, y: Int) {
        position = (x,y)
        status = .dead
        aliveNeighbours = 0
        geometry = -1
        neighboursGeometry = -1
    }
    
    func copy() -> Cell {
        let newCell = Cell(x: position.x, y: position.y)
        newCell.aliveNeighbours = aliveNeighbours
        newCell.status = status
        newCell.geometry = geometry
        newCell.neighboursGeometry = neighboursGeometry
        return newCell
    }
}

enum CellStatus {
    case alive
    case dead
}
