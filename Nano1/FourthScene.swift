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
    var pie: SKSpriteNode!
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
            if name == "RightArrow"
            {
                gameManager?.goToScene(.scene5)
            }
            else if name == "LeftArrow"
            {
                gameManager?.goToScene(.scene3)
            }
            else if name == "FoodTable"{
                setupCheckingObjectMode()
            }
            else if name == "DownArrow"
            {
                setupNormalMode()
            }
            else if name.contains("Pie") && !name.contains("Message"){
                changePieTexture()
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
    
    func setupNormalMode(){
        self.children.forEach { node in
            if node.name != nil {
                node.removeFromParent()
            }
        }
        setupLayer("RedRoomBackground", 1)
        setupTable()
        setupLeftArrow()
        setupRightArrow()
        
        if actionHappened(actionName: "MessageFound"){
            self.table.texture = SKTexture(imageNamed: "EmptyTable")
        }
    }
    
    func setupCheckingObjectMode(){
        self.children.forEach { node in
            if node.name != nil {
                node.removeFromParent()
            }
        }
        setupLayer("Floor", 1)
        setupEmptyTable()
        setupPie()
        setupDownArrow()
        
        if actionHappened(actionName: "MessageFound"){
            self.pie.texture = SKTexture(imageNamed: "PieMessage")
            self.pie.name = "PieMessage"
        }
    }
    
    func setupEmptyTable(){
        table = SKSpriteNode(imageNamed: "FoodTableUpEmpty")
        table.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        table.zPosition = 1
        table.name = "FoodTableUpEmpty"
        
        let tableBody = SKPhysicsBody(rectangleOf: CGSize(width: table.size.width, height: table.size.height))
        tableBody.isDynamic = false
        table.physicsBody = tableBody
        self.addChild(table)
    }
    func setupPie(){
        if !actionHappened(actionName: "MessageFound"){
            pie = SKSpriteNode(imageNamed: "Pie\(i)")
            pie.name = "Pie\(i)"
        }
        else {
            pie = SKSpriteNode(imageNamed: "PieMessage")
            pie.name = "PieMessage"
        }
        
        pie.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        pie.zPosition = 2
        
        let pieBody = SKPhysicsBody(rectangleOf: CGSize(width: pie.size.width, height: pie.size.height))
        pieBody.isDynamic = false
        pie.physicsBody = pieBody
        self.addChild(pie)
    }
    func changePieTexture() {
        if actionHappened(actionName: "MessageFound") {
            self.pie.texture = SKTexture(imageNamed: "PieMessage")
            self.pie.name = "PieMessage"
        }
        else {
            i += 1
            if i < 5 {
                self.pie.texture = SKTexture(imageNamed: "Pie\(i)")
            }
            if i == 5 {
                setAction(actionName: "MessageFound")
                self.pie.texture = SKTexture(imageNamed: "PieMessage")
            }
        }
    }
}
