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

    var gridBoxes: [[SCNNode]] = []
    var grid: Grid?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        Box.shared.setColors(deadColor: .gray, aliveColor: .red)
        
        grid = Grid(size: 32, distance: 8)
        
        createGrid()
        for line in gridBoxes {
            for box in line {
                scene.rootNode.addChildNode(box)
            }
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
            self.gridBoxes.append([SCNNode]())
            for j in 0..<grid.size {
                let boxNode = SCNNode(geometry: Box.shared.deadGeometry)
                boxNode.position.x = Float(grid.grid[i][j].position.x - grid.distance)
                boxNode.position.y = Float(grid.grid[i][j].position.y - grid.distance)
                boxNode.position.z = 0
                self.gridBoxes[i].append(boxNode)
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
            let index = findCell(node: result.node)
            
            let cell = grid?.grid[index.i][index.j]

            let boxNode = result.node
            
            switch cell?.status {
            case .alive:
                cell?.status = .dead
                boxNode.geometry = Box.shared.deadGeometry
                boxNode.position.z = 0.0
                break
            case .dead:
                cell?.status = .alive
                boxNode.geometry = Box.shared.aliveGeometry
                boxNode.position.z = 0.4
                break
            default:
                break
            }
            
        }
    }
    
    func findCell(node: SCNNode) -> (i: Int, j: Int) {
        for i in 0..<gridBoxes.count {
            if let j = gridBoxes[i].firstIndex(of: node) {
                return (i, j)
            }
        }
        return (0, 0)
    }
}
