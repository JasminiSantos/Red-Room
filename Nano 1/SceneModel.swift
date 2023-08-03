//
//  SceneModel.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 26/07/23.
//

import Foundation
import SpriteKit
class SceneModel: SKScene, SKPhysicsContactDelegate {
    var rightArrow: SKSpriteNode!
    var leftArrow: SKSpriteNode!
    var downArrow: SKSpriteNode!
    
    func setupLayer(_ imageName: String!, _ layer: Int!) {
        let sprite1 = SKSpriteNode(imageNamed: imageName)
        
        sprite1.size = frame.size
        sprite1.scene?.scaleMode = .aspectFit
        
        let layerNode = SKNode()
        layerNode.addChild(sprite1)
        
        layerNode.zPosition = CGFloat(layer)
        layerNode.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        self.addChild(layerNode)
        
    }
    func setupRightArrow(){
        rightArrow = SKSpriteNode(imageNamed: "RightArrow")
        rightArrow.position = CGPoint(x: frame.width*0.85, y: frame.height*0.5)
        rightArrow.zPosition = 1
        rightArrow.name = "RightArrow"
        
        let rightArrowBody = SKPhysicsBody(rectangleOf: CGSize(width: rightArrow.size.width, height: rightArrow.size.height))
        rightArrowBody.isDynamic = false
        rightArrow.physicsBody = rightArrowBody
        
        self.addChild(rightArrow)
    }
    
    func setupLeftArrow(){
        leftArrow = SKSpriteNode(imageNamed: "LeftArrow")
        leftArrow.position = CGPoint(x: frame.width*0.15, y: frame.height*0.5)
        leftArrow.zPosition = 1
        leftArrow.name = "LeftArrow"
        
        let leftArrowBody = SKPhysicsBody(rectangleOf: CGSize(width: leftArrow.size.width, height: leftArrow.size.height))
        leftArrowBody.isDynamic = false
        leftArrow.physicsBody = leftArrowBody
        
        self.addChild(leftArrow)
    }
    func removeLeftArrow(){
        leftArrow.removeFromParent()
    }
    func removeRightArrow(){
        rightArrow.removeFromParent()
    }
    
    func setupDownArrow(){
        downArrow = SKSpriteNode(imageNamed: "DownArrow")
        downArrow.position = CGPoint(x: frame.width*0.5, y: frame.height*0.2)
        downArrow.zPosition = 1
        downArrow.name = "DownArrow"
        
        let downArrowBody = SKPhysicsBody(rectangleOf: CGSize(width: downArrow.size.width, height: downArrow.size.height))
        downArrowBody.isDynamic = false
        downArrow.physicsBody = downArrowBody
        
        self.addChild(downArrow)
    }
    
    func setAction(actionName: String) {
        let defaults = UserDefaults.standard

        if !defaults.bool(forKey: actionName) {
            defaults.set(true, forKey: actionName)
        }
    }
    func actionHappened(actionName: String) -> Bool {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: actionName) {
            return true
        }
        return false
    }

}

