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

class GameViewController: UIViewController, SCNSceneRendererDelegate {

    var grid: Grid?

    var gridBoxes: [[SCNNode?]] = []
    var cameraNode: SCNNode!
    
    var cont: TimeInterval = 0.0
    var duration: TimeInterval = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene()
        
        Box.shared.setColors(aliveColor: .red)
        
        grid = Grid(size: 15, distance: 8)
        createGrid(rootNode: scene.rootNode)
        addRandomBlocks(n: 100)
        
        let scnView = self.view as! SCNView
        scnView.delegate = self

        scnView.scene = scene
        scnView.pointOfView?.position = SCNVector3Make(0, 0, 0)

        setupCamera(rootNode: scene.rootNode)
        scnView.allowsCameraControl = true

        scnView.showsStatistics = true

        scnView.backgroundColor = UIColor.white
        
        scnView.isPlaying = true
        
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
    
    func setupCamera(rootNode: SCNNode) {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 30)
        rootNode.addChildNode(cameraNode)
    }
    
    func createGrid(rootNode: SCNNode) {
        guard let grid = self.grid else { return }
        
        for i in 0..<grid.size {
            self.gridBoxes.append([SCNNode]())
            for _ in 0..<grid.size {
                self.gridBoxes[i].append(nil)
            }
        }
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
        guard let grid = self.grid else { return }
        
        for i in 0..<grid.grid.count {
            for j in 0..<grid.grid.count {
                let cell = grid.grid[i][j]
                let boxNode = gridBoxes[i][j]
                if cell.status == .alive {
                    if boxNode == nil {
                        gridBoxes[i][j] = createBox(x: cell.position.x, y: cell.position.y, size: grid.size)
                        
                        guard let box = gridBoxes[i][j] else { return }
                        
                        DispatchQueue.main.async {
                            let scnView = self.view as! SCNView
                            scnView.scene?.rootNode.addChildNode(box)
                        }
                    }
                } else {
                    if boxNode != nil {
                        gridBoxes[i][j]?.removeFromParentNode()
                        gridBoxes[i][j] = nil
                    }
                }
                
            }
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if time > cont {
            grid?.updateGrid()
            placeBoxes()
            cont = time + duration
        }
    }
    
    func createBox(x: Int, y: Int, size: Int) -> SCNNode {
        let boxNode = SCNNode(geometry: Box.shared.aliveGeometry)
        boxNode.position.x = Float(x - size/2)
        boxNode.position.y = Float(y - size/2)
        boxNode.position.z = 0.4
        
        return boxNode
    }
}
