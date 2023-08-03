//
//  ThirdScene.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 27/07/23.
//

import SwiftUI
import SpriteKit
class ThirdScene: SceneModel {
    weak var gameManager: GameManager?
    
    var table: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        setupLayer("RedRoomBackground", 1)
        setupTable()
        setupLeftArrow()
        setupRightArrow()
        
        if actionHappened(actionName: "FoodTableScene"){
            self.table.texture = SKTexture(imageNamed: "EmptyTable")
        }
        
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
                gameManager?.goToScene(.scene4)
            }
            else if name == "LeftArrow"
            {
                gameManager?.goToScene(.scene2)
            }
            else if name == "FoodTable"{
                gameManager?.goToScene(.foodTable)
            }
        }

    }
    func setupTable(){
        table = SKSpriteNode(imageNamed: "FoodTable")
        table.position = CGPoint(x: frame.width*0.5, y: frame.height*0.3)
        table.zPosition = 1
        table.name = "FoodTable"
        
        let recorderBody = SKPhysicsBody(rectangleOf: CGSize(width: table.size.width, height: table.size.height))
        recorderBody.isDynamic = false
        table.physicsBody = recorderBody
        self.addChild(table)
    }
    
}
