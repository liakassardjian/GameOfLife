//
//  Sphere.swift
//  GameOfLife
//
//  Created by Lia Kassardjian on 05/11/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation

import SceneKit

class Sphere {
    static let shared = Sphere()
    
    private init() {}
    
    var redGeometry = SCNSphere(radius: 0.5)
    var blueGeometry = SCNSphere(radius: 0.5)
    var whiteGeometry = SCNSphere(radius: 0.5)
    var yellowGeometry = SCNSphere(radius: 0.5)
    var greenGeometry = SCNSphere(radius: 0.5)
    
    func setColors() {
        redGeometry.firstMaterial?.diffuse.contents = UIColor.systemRed
        blueGeometry.firstMaterial?.diffuse.contents = UIColor.systemBlue
        whiteGeometry.firstMaterial?.diffuse.contents = UIColor.white
        yellowGeometry.firstMaterial?.diffuse.contents = UIColor.systemYellow
        greenGeometry.firstMaterial?.diffuse.contents = UIColor.systemGreen
    }
    
}
