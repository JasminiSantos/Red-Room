//
//  MainMenu.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 26/07/23.
//

import SwiftUI
import SpriteKit
class MainMenu: SKScene, SKPhysicsContactDelegate {
    weak var gameManager: GameManager?
    
    var startButton: SKSpriteNode!
    var aboutButton: SKSpriteNode!
    var backButton: SKSpriteNode!
    var authorText: SKSpriteNode!
    var logo: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        gameManager?.playSound(.background)
        resetUserDefaults()
        setupLayer("StatueBackground", 1)
        setupLogo()
        setupInitialMode()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)

        if let name = touchedNode.name
        {
            if name == "PlayButton" {
                gameManager?.goToScene(.scene1)
            }
            if name == "AboutButton" {
                startButton.removeFromParent()
                aboutButton.removeFromParent()
                
                setupAboutMode()
            }
            if name == "BackButton"{
                backButton.removeFromParent()
                authorText.removeFromParent()
                
                setupInitialMode()
            }
        }

    }
    
    func setupLayer(_ imageName: String!, _ layer: Int!) {
        let sprite1 = SKSpriteNode(imageNamed: imageName)
        sprite1.size.height = self.size.height
        
        let layerNode = SKNode()
        layerNode.addChild(sprite1)
        
        layerNode.zPosition = CGFloat(layer)
        layerNode.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        self.addChild(layerNode)
    }
    func setupLogo() {
        logo = SKSpriteNode(imageNamed: "Logo")
        logo.position = CGPoint(x: frame.width*0.5, y: frame.height*0.65)
        logo.zPosition = 2
        logo.name = "Logo"
        self.addChild(logo)
    }
    func setupInitialMode(){
        startButton = SKSpriteNode(imageNamed: "PlayButton")
        startButton.position = CGPoint(x: frame.width*0.5, y: frame.height*0.2)
        startButton.size = CGSize(width: frame.width*0.56, height: frame.height*0.05)
        startButton.zPosition = 1
        startButton.name = "PlayButton"

        let startButtonBody = SKPhysicsBody(rectangleOf: CGSize(width: startButton.size.width, height: startButton.size.height))
        startButtonBody.isDynamic = false
        
        aboutButton = SKSpriteNode(imageNamed: "AboutButton")
        aboutButton.position = CGPoint(x: frame.width*0.5, y: frame.height*0.1)
        aboutButton.size = CGSize(width: frame.width*0.56, height: frame.height*0.05)
        aboutButton.zPosition = 1
        aboutButton.name = "AboutButton"
        
        let aboutButtonBody = SKPhysicsBody(rectangleOf: CGSize(width: startButton.size.width, height: startButton.size.height))
        aboutButtonBody.isDynamic = false

        startButton.physicsBody = startButtonBody
        aboutButton.physicsBody = aboutButtonBody
        self.addChild(startButton)
        self.addChild(aboutButton)
    }
    
    func setupAboutMode(){
        backButton = SKSpriteNode(imageNamed: "BackButton")
        backButton.position = CGPoint(x: frame.width*0.5, y: frame.height*0.15)
        backButton.size = CGSize(width: frame.width*0.56, height: frame.height*0.05)
        backButton.zPosition = 1
        backButton.name = "BackButton"
        
        authorText = SKSpriteNode(imageNamed: "author")
        authorText.position = CGPoint(x: frame.width*0.5, y: frame.height*0.5)
        authorText.zPosition = 1
        authorText.name = "author"
        
        let backButtonBody = SKPhysicsBody(rectangleOf: CGSize(width: backButton.size.width, height: backButton.size.height))
        backButtonBody.isDynamic = false
        backButton.physicsBody = backButtonBody
        
        self.addChild(backButton)
        self.addChild(authorText)
    }
    
    func resetUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.synchronize()
            print("UserDefaults data reset successfully.")
        }
    }

}
