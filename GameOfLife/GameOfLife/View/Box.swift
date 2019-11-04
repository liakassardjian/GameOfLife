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
    
    var redGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    var blueGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    var whiteGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    var yellowGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    var greenGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    
    func setColors(aliveColor: UIColor) {
        redGeometry.firstMaterial?.diffuse.contents = UIColor.systemRed
        blueGeometry.firstMaterial?.diffuse.contents = UIColor.systemBlue
        whiteGeometry.firstMaterial?.diffuse.contents = UIColor.white
        yellowGeometry.firstMaterial?.diffuse.contents = UIColor.systemYellow
        greenGeometry.firstMaterial?.diffuse.contents = UIColor.systemGreen
    }
    
}
