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
    var orangeGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    var yellowGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    var greenGeometry = SCNBox(width: 0.9, height: 0.9, length: 0.9, chamferRadius: 0.005)
    
    func setColors() {
        redGeometry.firstMaterial?.diffuse.contents = UIColor.systemRed
        redGeometry.firstMaterial?.specular.contents = UIColor.white

        blueGeometry.firstMaterial?.diffuse.contents = UIColor.systemBlue
        blueGeometry.firstMaterial?.specular.contents = UIColor.white

        orangeGeometry.firstMaterial?.diffuse.contents = UIColor.systemPurple
        orangeGeometry.firstMaterial?.specular.contents = UIColor.white

        yellowGeometry.firstMaterial?.diffuse.contents = UIColor.systemYellow
        yellowGeometry.firstMaterial?.specular.contents = UIColor.white

        greenGeometry.firstMaterial?.diffuse.contents = UIColor.systemGreen
        greenGeometry.firstMaterial?.specular.contents = UIColor.white

    }
    
}
