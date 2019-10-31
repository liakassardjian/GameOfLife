//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Lia Kassardjian on 31/10/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    var gridBoxes: [SCNNode] = []
    var grid: Grid?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        grid = Grid(size: 32, distance: 8)
        
        createGrid()
        for box in gridBoxes {
            scene.rootNode.addChildNode(box)
        }
        // retrieve the SCNView
        let scnView = self.view as! SCNView

        // set the scene to the view
        scnView.scene = scene
        scnView.pointOfView?.position = SCNVector3Make(0, 0, 0)

        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true

        // show statistics such as fps and timing information
        scnView.showsStatistics = true

        // configure the view
        scnView.backgroundColor = UIColor.white
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    func createGrid() {
        guard let grid = self.grid else { return }
        
        for i in 0..<grid.size {
            for j in 0..<grid.size {
                let geometry = SCNBox(width: 0.8, height: 0.8, length: 0, chamferRadius: 0.005)
                geometry.firstMaterial?.diffuse.contents = UIColor.gray
                let boxNode = SCNNode(geometry: geometry)
                boxNode.position.x = grid.grid[i][j].position.x
                boxNode.position.y = grid.grid[i][j].position.y
                boxNode.position.z = 0
                self.gridBoxes.append(boxNode)
            }
        }
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView

        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]

            if gridBoxes.contains(result.node) {
                let geometry = SCNBox(width: 0.8, height: 0.8, length: 0.8, chamferRadius: 0.005)
                geometry.firstMaterial?.diffuse.contents = UIColor.red
                let boxNode = SCNNode(geometry: geometry)
                boxNode.position = result.node.position
                boxNode.position.z = 0.4
                scnView.scene?.rootNode.addChildNode(boxNode)
            }
        }
    }
    
}
