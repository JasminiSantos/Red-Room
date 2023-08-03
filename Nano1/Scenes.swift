//
//  Scenes.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 26/07/23.
//

import SwiftUI

enum Scenes: String, Identifiable, CaseIterable {
    case menu, scene1, scene2, scene3, scene4, scene5

    var id: String { self.rawValue }
}

