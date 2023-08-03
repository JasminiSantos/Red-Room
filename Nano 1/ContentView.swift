//
//  ContentView.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 25/07/23.
//

import SwiftUI
import SpriteKit
struct ContentView: View {
    @StateObject var gameManager = GameManager()
    
    var body: some View {
        
        VStack {
            switch gameManager.selectedScene {
                case .menu:
                    SpriteView(scene: getMenu()).ignoresSafeArea().transition(.opacity)
                case .scene1:
                    SpriteView(scene: getScene1()).ignoresSafeArea().transition(.opacity)
                case .scene2:
                    SpriteView(scene: getScene2()).ignoresSafeArea().transition(.opacity)
                case .scene3:
                    SpriteView(scene: getScene3()).ignoresSafeArea().transition(.opacity)
                case .scene4:
                    SpriteView(scene: getScene4()).ignoresSafeArea().transition(.opacity)
                case .scene5:
                    SpriteView(scene: getScene5()).ignoresSafeArea().transition(.opacity)
                default:
                    fatalError("Unhandled case for gameManager.selectedScene")
            }
        }
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            AppDelegate.orientationLock = .portrait
        }.onDisappear {
            AppDelegate.orientationLock = .all
        }
    }
    func getMenu() -> SKScene {
        let height = 844
        let width = 390
            
        let scene = MainMenu(size: CGSize(width: width, height: height))
        scene.scaleMode = .aspectFit
        scene.gameManager = gameManager
        return scene
    }
    
    func getScene1() -> SKScene {
        let height = 844
        let width = 390
        
        let scene = FirstScene(size: CGSize(width: width, height: height))
        scene.scaleMode = .aspectFit
        scene.gameManager = gameManager
        return scene
    }
    func getScene2() -> SKScene {
        let height = 844
        let width = 390
        
        let scene = SecondScene(size: CGSize(width: width, height: height))
        scene.scaleMode = .aspectFit
        scene.gameManager = gameManager
        return scene
    }
    func getScene3() -> SKScene {
        let height = 844
        let width = 390
        
        let scene = ThirdScene2(size: CGSize(width: width, height: height))
        scene.scaleMode = .aspectFit
        scene.gameManager = gameManager
        return scene
    }
    func getScene4() -> SKScene {
        let height = 844
        let width = 390
        
        let scene = FourthScene(size: CGSize(width: width, height: height))
        scene.scaleMode = .aspectFit
        scene.gameManager = gameManager
        return scene
    }
    func getScene5() -> SKScene {
        let height = 844
        let width = 390
        
        let scene = FifthScene(size: CGSize(width: width, height: height))
        scene.scaleMode = .aspectFit
        scene.gameManager = gameManager
        return scene
    }
}
