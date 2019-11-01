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

    var grid: Grid?

    var gridBoxes: [[SCNNode]] = []
    var cameraNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()
        
        Box.shared.setColors(deadColor: .gray, aliveColor: .red)
        
        grid = Grid(size: 15, distance: 8)
        createGrid(rootNode: scene.rootNode)
        addRandomBlocks(n: 100)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView

        scnView.scene = scene
        scnView.pointOfView?.position = SCNVector3Make(0, 0, 0)

        setupCamera(rootNode: scene.rootNode)
        scnView.allowsCameraControl = true

        // show statistics such as fps and timing information
        scnView.showsStatistics = true

        // configure the view
        scnView.backgroundColor = UIColor.white
        
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
    
    func createGrid(rootNode: SCNNode) {
        guard let grid = self.grid else { return }
        
        for i in 0..<grid.size {
            self.gridBoxes.append([SCNNode]())
            for j in 0..<grid.size {
                let boxNode = SCNNode(geometry: Box.shared.deadGeometry)
                boxNode.position.x = Float(grid.grid[i][j].position.x - grid.size/2)
                boxNode.position.y = Float(grid.grid[i][j].position.y - grid.size/2)
                boxNode.position.z = 0
                self.gridBoxes[i].append(boxNode)
                rootNode.addChildNode(boxNode)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            grid?.updateGrid()
            placeBoxes()
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
    
    func addRandomBlocks(n: Int) {
        for _ in 0..<n {
            guard let size = grid?.size else { return }
            
            var x = Int.random(in: 0..<size)
            var y = Int.random(in: 0..<size)
            var cell = grid?.grid[x][y]
            
            while cell?.status == .alive {
                x = Int.random(in: 0..<size)
                y = Int.random(in: 0..<size)
                cell = grid?.grid[x][y]
            }
            
            cell?.status = .alive
        }
        placeBoxes()
    }
    
    func placeBoxes() {
        guard let grid = self.grid?.grid else { return }
        
        for i in 0..<grid.count {
            for j in 0..<grid.count {
                let cell = grid[i][j]
                let boxNode = gridBoxes[i][j]
                if cell.status == .alive {
                    boxNode.geometry = Box.shared.aliveGeometry
                    boxNode.position.z = 0.4
                } else {
                    boxNode.geometry = Box.shared.deadGeometry
                    boxNode.position.z = 0.0
                }
                
            }
        }
    }
    
    func setupCamera(rootNode: SCNNode) {
      cameraNode = SCNNode()
      cameraNode.camera = SCNCamera()
      cameraNode.position = SCNVector3(x: 0, y: 0, z: 30)
      rootNode.addChildNode(cameraNode)
    }
}
