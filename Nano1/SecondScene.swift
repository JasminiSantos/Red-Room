//
//  SecondScene.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 29/07/23.
//

import SpriteKit
class SecondScene: SceneModel {
    weak var gameManager: GameManager?
    
    var message: SKSpriteNode!
    var messageDisplayTime: TimeInterval = 2.0
    
    var armchairBox: SKSpriteNode!
    var i = 1;
    
    override func didMove(to view: SKView) {
        setupNormalMode()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)

        if let name = touchedNode.name
        {
            if name == "LeftArrow" {
                gameManager?.goToScene(.scene1)
            }
            else if name == "RightArrow" {
                gameManager?.goToScene(.scene3)
            }
            else if name == "DownArrow"
            {
                setupNormalMode()
            }
            else if name == "ArmchairBox" {
                if !actionHappened(actionName: "DiaryKey"){
                    setupMessage()
                    gameManager?.playSound(.lockedBox)
                }
                else {
                    armchairBox.texture = SKTexture(imageNamed: "ArmchairOpenBox")
                    armchairBox.name = "ArmchairOpenBox"
                    setAction(actionName: "BoxIsOpen")
                    gameManager?.playSound(.unlocked)
                }
            }
            else if name == "ArmchairOpenBox" {
                setupCheckingObjectMode()
            }
            else if name.contains("Box") {
                changeBoxTexture()
            }
        }

    }
    func setupArmchairBox(){
        armchairBox = SKSpriteNode(imageNamed: "ArmchairBox")
        armchairBox.position = CGPoint(x: frame.width*0.5, y: frame.height*0.3)
        armchairBox.zPosition = 1
        armchairBox.name = "ArmchairBox"
        
        let armchairBoxBody = SKPhysicsBody(rectangleOf: CGSize(width: armchairBox.size.width, height: armchairBox.size.height))
        armchairBoxBody.isDynamic = false
        armchairBox.physicsBody = armchairBoxBody
        self.addChild(armchairBox)
    }
    
    func setupBox(){
        armchairBox = SKSpriteNode(imageNamed: "Box\(i)")
        armchairBox.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        armchairBox.zPosition = 1
        armchairBox.name = "Box\(i)"
        
        let armchairBoxBody = SKPhysicsBody(rectangleOf: CGSize(width: armchairBox.size.width, height: armchairBox.size.height))
        armchairBoxBody.isDynamic = false
        armchairBox.physicsBody = armchairBoxBody
        self.addChild(armchairBox)
    }
    
    func changeBoxTexture(){
        i += 1
        if i < 3 {
            self.armchairBox.texture = SKTexture(imageNamed: "Box\(i)")
        }
        if i == 2 {
            setAction(actionName: "hasGoldenRing")
        }
    }
    
    func setupMessage(){
        message = SKSpriteNode(imageNamed: "BoxMessage")
        message.position = CGPoint(x: frame.width*0.5, y: frame.height*0.7)
        message.zPosition = 1
        message.name = "BoxMessage"
        
        self.addChild(message)
        
        removeLeftArrow()
        removeRightArrow()
        
        Timer.scheduledTimer(withTimeInterval: messageDisplayTime, repeats: false) { [weak self] _ in
            self?.hideMessage()
            self?.setupLeftArrow()
            self?.setupRightArrow()
        }
    }
    
    func hideMessage() {
        message.removeFromParent()
    }
    
    func setupNormalMode(){
        self.children.forEach { node in
            if node.name != nil {
                node.removeFromParent()
            }
        }
        setupLayer("RedWallBackground", 1)
        setupRightArrow()
        setupLeftArrow()
        setupArmchairBox()
        
        if actionHappened(actionName: "BoxIsOpen"){
            armchairBox.texture = SKTexture(imageNamed: "ArmchairOpenBox")
            armchairBox.name = "ArmchairOpenBox"
        }
        if actionHappened(actionName: "hasGoldenRing") {
            removeLeftArrow()
            removeRightArrow()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
                self?.gameManager?.goToScene(.scene1)
                self?.setAction(actionName: "BlackHole")
            }
        }
    }
    func setupCheckingObjectMode(){
        self.children.forEach { node in
            if node.name != nil {
                node.removeFromParent()
            }
        }
        setupLayer("Floor", 1)
        setupBox()
        setupDownArrow()
    }
}
