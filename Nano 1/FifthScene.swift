//
//  FourthScene.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 27/07/23.
//

import SwiftUI
import SpriteKit
class FourthScene: SceneModel {
    weak var gameManager: GameManager?
    
    var table: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        setupLayer("RedWallBackground", 1)
        setupTable()
        setupLeftArrow()
        setupRightArrow()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)

        if let name = touchedNode.name
        {
            if name == "RightArrow"
            {
                gameManager?.goToScene(.scene5)
            }
            if name == "LeftArrow"
            {
                gameManager?.goToScene(.scene3)
            }
            if name == "SafeboxTable"{
                gameManager?.goToScene(.keyboardScene)
            }
        }

    }
    func setupTable(){
        table = SKSpriteNode(imageNamed: "SafeboxTable")
        table.position = CGPoint(x: frame.width*0.5, y: frame.height*0.3)
        table.zPosition = 1
        table.name = "SafeboxTable"
        
        let tableBody = SKPhysicsBody(rectangleOf: CGSize(width: table.size.width, height: table.size.height))
        tableBody.isDynamic = false
        table.physicsBody = tableBody
        self.addChild(table)
    }
    
}
