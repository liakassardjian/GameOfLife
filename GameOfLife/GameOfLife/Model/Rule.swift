//
//  Rule.swift
//  GameOfLife
//
//  Created by Lia Kassardjian on 31/10/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

class Rule {
    var initialStatus: CellStatus
    var finalStatus: CellStatus
    var maxValue: Int
    var minValue: Int
    
    init(initialStatus: CellStatus, finalStatus: CellStatus, maxValue: Int, minValue: Int) {
        self.initialStatus = initialStatus
        self.finalStatus = finalStatus
        self.maxValue = maxValue
        self.minValue = minValue
    }
    
    func applyRule(cell: Cell) {
        if cell.aliveNeighbours >= minValue,
            cell.aliveNeighbours <= maxValue,
            cell.status == initialStatus {
            cell.status = finalStatus
        }
    }
}
