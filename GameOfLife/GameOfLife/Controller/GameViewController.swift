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

    var gridBoxes: [[[SCNNode?]]] = []
    var cameraNode: SCNNode!
    
    var cont: TimeInterval = 0.0
    var duration: TimeInterval = 0.2
    
    var geometry: [SCNBox] = [Box.shared.redGeometry,
                              Box.shared.blueGeometry,
                              Box.shared.purpleGeometry,
                              Box.shared.yellowGeometry,
                              Box.shared.greenGeometry,
                              Box.shared.orangeGeometry,
                              Box.shared.pinkGeometry]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene()
        
        Box.shared.setColors()
        
        grid = Grid(size: 32, geometryCount: geometry.count)
        addRandomBlocks(n: 400)
        
        let scnView = self.view as! SCNView
        scnView.delegate = self

        scnView.scene = scene
        scnView.pointOfView?.position = SCNVector3Make(0, 0, 0)

        setupLight(rootNode: scene.rootNode)
        setupCamera(rootNode: scene.rootNode)
        scnView.allowsCameraControl = true

        scnView.backgroundColor = UIColor.black
        
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
        cameraNode.position = SCNVector3(x: 0, y: -40, z: -20)
        cameraNode.look(at: SCNVector3(0, 0, 0))
        
        rootNode.addChildNode(cameraNode)
        
    }
    
    func setupLight(rootNode: SCNNode) {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: -100, z: -100)
        rootNode.addChildNode(lightNode)

        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.gray
        rootNode.addChildNode(ambientLightNode)
    }
    
    func createGrid(rootNode: SCNNode) -> Bool {
        guard let grid = self.grid else { return false }
        gridBoxes.append([[SCNNode]]())
        
        for i in 0..<grid.size {
            self.gridBoxes[grid.generation].append([SCNNode]())
            for _ in 0..<grid.size {
                self.gridBoxes[grid.generation][i].append(nil)
            }
        }
        
        return true
    }
    
    func createBox(x: Int, y: Int, size: Int, g: Int) -> SCNNode {
        let boxNode = SCNNode(geometry: geometry[g])
        boxNode.position.x = Float(x - size/2)
        boxNode.position.y = Float(y - size/2)
        
        guard let generation = grid?.generation else { return boxNode }
        boxNode.position.z = 0.5 * Float(generation)
        
        return boxNode
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
            
            cell?.geometry = Int.random(in: 0..<geometry.count)
            cell?.status = .alive
        }
        placeBoxes()
    }
    
    func placeBoxes() {
        guard let grid = self.grid else { return }
        
        DispatchQueue.main.async {
            guard let scnView = self.view as? SCNView else { return }
            guard let scene = scnView.scene else { return }
            if self.createGrid(rootNode: scene.rootNode) {
                self.replaceBoxes()
                print(grid.generation)
                
                if grid.generation - 100 >= 0 {
                    self.removeGeneration(g: grid.generation - 100)
                }
                
                for i in 0..<grid.grid.count {
                    for j in 0..<grid.grid.count {
                        let cell = grid.grid[i][j]
                        
                        let boxNode = self.gridBoxes[grid.generation][i][j]
                        if cell.status == .alive {
                            if boxNode == nil {
                                self.gridBoxes[grid.generation][i][j] = self.createBox(x: cell.position.x, y: cell.position.y, size: grid.size, g: cell.geometry)
                            }
                            
                            guard let box = self.gridBoxes[grid.generation][i][j] else { return }
                            
                            scene.rootNode.addChildNode(box)
                        }
                    }
                }
                
            }
            
        }
    }
    
    func replaceBoxes() {
        guard let grid = self.grid else { return }
        
        for g in 0..<grid.generation {
            for i in 0..<grid.grid.count {
                for j in 0..<grid.grid.count {
                    let boxNode = gridBoxes[g][i][j]
                    boxNode?.position.z = 0.5 * Float(grid.generation - g)
                }
            }
        }
    }
    
    func removeGeneration(g: Int) {
        for i in 0..<gridBoxes[g].count {
            for j in 0..<gridBoxes[g][i].count {
                gridBoxes[g][i][j]?.removeFromParentNode()
                gridBoxes[g][i][j]?.geometry?.firstMaterial?.diffuse.contents = nil
                gridBoxes[g][i][j]?.geometry?.firstMaterial?.specular.contents = nil
                gridBoxes[g][i][j] = nil
            }
        }
        
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if time > cont {
            grid?.updateGrid()
            placeBoxes()
            cont = time + duration
            let posY = -40.0
            let posZ = cameraNode.position.z - 0.5
            let moveCamera = SCNAction.move(to: SCNVector3(0.0, posY, Double(posZ)), duration: duration)
            cameraNode.runAction(moveCamera)
        }
    }

}
