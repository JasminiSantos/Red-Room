//
//  FifthScene.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 27/07/23.
//

import SwiftUI
import SpriteKit
class FifthScene: SceneModel {
    weak var gameManager: GameManager?
    
    var table: SKSpriteNode!
    var safebox: SKSpriteNode!
    var screen: SKSpriteNode!
    var diary: SKSpriteNode!
    var label: SKLabelNode!
    var correctInput = "8436957273668942884397336"
    var i = 1
    
    let keyboardButtons: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["C", "Del", "Enter"]
    ]
    
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
            if name == "LeftArrow"
            {
                gameManager?.goToScene(.scene4)
            }
            else if name == "SafeboxTable"{
                if actionHappened(actionName: "SafeboxIsOpen"){
                    setupCheckingDiaryMode()
                }
                else {
                    setupCheckingObjectMode()
                }
            }
            else if name == "DownArrow" {
                setupNormalMode()
            }
            else if keyboardButtons.joined().contains(name) {
                handleButtonTap(name)
            }
            else if name == "OpenSafebox" {
                setupCheckingDiaryMode()
            }
            else if name.contains("Diary"){
                changeDiaryTexture()
            }
        }

    }
    func setupNormalMode(){
        self.children.forEach { node in
            if node.name != nil {
                node.removeFromParent()
            }
        }
        if label != nil {
            label.removeFromParent()
        }
        
        setupLayer("RedWallBackground", 1)
        setupTable()
        setupLeftArrow()
    }
    
    func setupCheckingObjectMode(){
        self.children.forEach { node in
            if node.name != nil {
                node.removeFromParent()
            }
        }
        
        if label != nil {
            label.removeFromParent()
        }
        
        setupLayer("SafeboxTableBackground", 1)
        setupSafebox()
        setupDownArrow()
    }
    func setupCheckingDiaryMode(){
        self.children.forEach { node in
            if node.name != nil {
                node.removeFromParent()
            }
        }
        if label != nil {
            label.removeFromParent()
        }
        
        setupLayer("Floor", 1)
        setupDiary()
        setupDownArrow()
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
    
    func setupButtons() {
        var i = 12;
        for (rowIndex, row) in keyboardButtons.enumerated().reversed() {
            for (colIndex, buttonLabel) in row.enumerated().reversed(){
                let button = createButton(id: i)
                i -= 1
                let x = (CGFloat(colIndex) - 1) * 100
                let y = (CGFloat(rowIndex) - 2) * 60
                button.position = CGPoint(x: frame.midX + x, y: frame.midY + y)
                button.zPosition = 3
                button.name = buttonLabel
                
                let buttonBody = SKPhysicsBody(rectangleOf: CGSize(width: button.size.width, height: button.size.height))
                buttonBody.isDynamic = false
                button.physicsBody = buttonBody
                
                self.addChild(button)
            }
        }
    }

    func createButton(id: Int) -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: "Button\(id)")
        return button
    }
    func setupSafebox(){
        safebox = SKSpriteNode(imageNamed: "Safebox")
        safebox.position = CGPoint(x: frame.width*0.5, y: frame.height*0.52)
        safebox.zPosition = 2
        safebox.name = "Safebox"
    
        self.addChild(safebox)
        
        screen = SKSpriteNode(imageNamed: "Screen")
        screen.position = CGPoint(x: frame.width*0.5, y: frame.height*0.67)
        screen.zPosition = 3
        screen.name = "Screen"
        
        label = SKLabelNode(fontNamed: "Helvetica")
        label.text = ""
        label.fontSize = 14
        label.fontColor = .white
        label.position = screen.convert(CGPoint(x: 0, y: 0)
, to: self)
        label.zPosition = 4
        
        self.addChild(label)
        self.addChild(screen)
        
        setupButtons()
    }
    func setupDiary(){
        diary = SKSpriteNode(imageNamed: "Diary\(i)")
        diary.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        diary.zPosition = 2
        diary.name = "Diary\(i)"
        self.addChild(diary)
    }
    
    func changeDiaryTexture(){
        if actionHappened(actionName: "DiaryKey"){
            self.diary.texture = SKTexture(imageNamed: "Diary3")
        }
        else {
            i += 1
            if i < 4 {
                self.diary.texture = SKTexture(imageNamed: "Diary\(i)")
            }
            if i == 3 {
                setAction(actionName: "DiaryKey")
            }
        }
    }
    
    private func handleButtonTap(_ key: String) {
        if key != "Enter"{
            gameManager?.playSound(.key)
        }
        
        if key == "Del" {
            self.label.text! = String(self.label.text!.dropLast())
        }
        else if key == "C" {
            self.label.text! = ""
        }
        else if key == "Enter" {
            if self.label.text! == correctInput {
                print("Resposta correta")
                gameManager?.playSound(.unlocked)
                setAction(actionName: "SafeboxIsOpen")
                openTheSafebox()
                label.isHidden = true
                screen.isHidden = true
            }
            else {
                gameManager?.playSound(.wrongPassword)
                print("Resposta incorreta")
            }
        }
        else {
            self.label.text! += key
        }
    }
    private func removeAllButtons() {
        self.children.forEach { node in
            if node.name != nil && keyboardButtons.flatMap({ $0 }).contains(node.name!) {
                node.isHidden = true
            }
        }
    }
    private func openTheSafebox(){
        removeAllButtons()
        self.safebox.texture = SKTexture(imageNamed: "OpenSafebox")
        safebox.name = "OpenSafebox"
    }
    
}
