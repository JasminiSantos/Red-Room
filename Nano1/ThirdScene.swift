//
//  ThirdScene..swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 26/07/23.
//

import SwiftUI
import SpriteKit
class ThirdScene2: SceneModel {
    weak var gameManager: GameManager?
    
    var message: SKSpriteNode!
    var recorder: SKSpriteNode!
    var selectedSoundType: SoundType = .reverse1
    var messageDisplayTime: TimeInterval = 5.0
    var i = 1;
    
    override func didMove(to view: SKView) {
        setupLayer("RedRoomBackground", 1)
        setupRecorder()
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
            if name == "Recorder" {
                i = 1
                removeLeftArrow()
                removeRightArrow()
                setupMessage()
                gameManager?.lowerVolume(for: .background, by: 0.6)
            }
            else if name == "RightArrow" {
                gameManager?.goToScene(.scene4)
            }
            else if name == "LeftArrow" {
                gameManager?.goToScene(.scene2)
            }
        }

    }
    func showMessage() {
        let texture = SKTexture(imageNamed: "RecordMessage\(i)")
        message.texture = texture
    }
    func setupRecorder(){
        recorder = SKSpriteNode(imageNamed: "Recorder")
        recorder.position = CGPoint(x: frame.width*0.5, y: frame.height*0.3)
        recorder.size = CGSize(width: frame.width*0.29, height: frame.height*0.08)
        recorder.zPosition = 1
        recorder.name = "Recorder"
        
        let recorderBody = SKPhysicsBody(rectangleOf: CGSize(width: recorder.size.width, height: recorder.size.height))
        recorderBody.isDynamic = false
        recorder.physicsBody = recorderBody
        self.addChild(recorder)
    }
    
    func setupMessage(){
        message = SKSpriteNode(imageNamed: "RecordMessage\(i)")
        message.position = CGPoint(x: frame.width*0.5, y: frame.height*0.7)
        message.zPosition = 1
        message.name = "RecordMessage\(i)"
        
        self.addChild(message)
        
        switch i {
        case 1:
            selectedSoundType = .reverse1
        case 2:
            selectedSoundType = .reverse2
        case 3:
            selectedSoundType = .reverse3
        case 4:
            selectedSoundType = .reverse4
        case 5:
            selectedSoundType = .reverse5
        default:
            selectedSoundType = .reverse1
        }
        gameManager?.playSound(selectedSoundType)
        messageDisplayTime = gameManager?.getAudioDuration(for: selectedSoundType) ?? 0
        
        Timer.scheduledTimer(withTimeInterval: messageDisplayTime, repeats: false) { [weak self] _ in
            self?.hideMessage()
            self?.i += 1
            if self!.i < 6 {
                self?.setupMessage()
            }
            else {
                self?.gameManager?.resetVolume(for: .background)
                self?.setupLeftArrow()
                self?.setupRightArrow()
            }
        }
    }
    
    func hideMessage() {
        message.removeFromParent()
    }
    
}

