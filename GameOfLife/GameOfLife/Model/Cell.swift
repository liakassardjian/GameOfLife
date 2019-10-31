//
//  Cell.swift
//  GameOfLife
//
//  Created by Lia Kassardjian on 31/10/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

class Cell {
    var position: (x: Float, y: Float)
    var status: CellStatus
    
    init(x: Float, y: Float) {
        position = (x,y)
        status = .dead
    }
}

enum CellStatus {
    case alive
    case dead
}
