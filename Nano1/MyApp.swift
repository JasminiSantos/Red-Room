//
//  Nano_1App.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 25/07/23.
//

import SwiftUI

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
         
    static var orientationLock = UIInterfaceOrientationMask.portrait
 
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
