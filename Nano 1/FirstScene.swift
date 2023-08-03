//
//  FirstScene.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 26/07/23.
//

import SwiftUI
import SpriteKit
class FirstScene: SceneModel {
    weak var gameManager: GameManager?
    var message: SKSpriteNode!
    var messageDisplayTime: TimeInterval = 5.0
    var blackhole: SKSpriteNode!
    override func didMove(to view: SKView) {
        setupLayer("StatueBackground", 1)
        
        if !actionHappened(actionName: "FirstScene"){
            setupMessage()
            Timer.scheduledTimer(withTimeInterval: messageDisplayTime, repeats: false) { [weak self] _ in
                self?.hideMessage()
                self?.setupRightArrow()
            }
        }
        else {
            if actionHappened(actionName: "BlackHole"){
                setupBlackHole()
                gameManager?.stopSound(.background)
                gameManager?.playSound(.blackhole)
            }
            else {
                setupRightArrow()
            }
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
                setAction(actionName: "FirstScene")
                gameManager?.goToScene(.scene2)
            }
            else if name == "BlackHole" {
                gameManager?.stopSound(.blackhole)
                gameManager?.goToScene(.menu)
            }
        }

    }
    
    func setupMessage(){
        message = SKSpriteNode(imageNamed: "WhereAmI")
        message.position = CGPoint(x: frame.width*0.5, y: frame.height*0.7)
        message.zPosition = 1
        message.name = "WhereAmI"
        
        self.addChild(message)
    }
    
    func hideMessage() {
        message.removeFromParent()
    }
    func setupBlackHole(){
        blackhole = SKSpriteNode(imageNamed: "BlackHole")
        blackhole.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        blackhole.zPosition = 1
        blackhole.name = "BlackHole"
        
        let blackholeBody = SKPhysicsBody(rectangleOf: CGSize(width: blackhole.size.width, height: blackhole.size.height))
        blackholeBody.isDynamic = false
        blackhole.physicsBody = blackholeBody
        self.addChild(blackhole)
    }
}
