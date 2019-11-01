//
//  Box.swift
//  GameOfLife
//
//  Created by Lia Kassardjian on 31/10/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import SceneKit

class Box {
    static let shared = Box()
    
    private init() {}
    
    var aliveGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    
    func setColors(aliveColor: UIColor) {
        aliveGeometry.firstMaterial?.diffuse.contents = aliveColor
    }
    
}
