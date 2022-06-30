//
//  Player1Settings.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 24/06/2022.
//

import Foundation
import SwiftUI

class PlayerSettings: ObservableObject {
    @Published var player1 = Player(){
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var player2 = Player(){
        didSet {
            objectWillChange.send()
        }
    }
//
//    @Published var player2Score = 0
//    @Published var player2ImageName = "swordsman"
//    @Published var player2Name = "Pari"
}

class Player : ObservableObject{
    @Published var score = 0
    @Published var imageName = "swordsman"
    @Published var name = "Pari"
    
//    init(score: Int, imageName: String, name: String) {
//            self.score = score
//            self.imageName = imageName
//            self.name = name
//        }
}

enum DicePlayer {
    case player1
    case player2
}
