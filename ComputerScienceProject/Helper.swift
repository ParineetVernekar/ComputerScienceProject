//
//  Helper.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 24/06/2022.
//

import Foundation
import SwiftUI

class PlayerSettings: ObservableObject {
    @Published var player1 = Player(playerNumber: .player1){
        didSet {
            // when an observed value is changed, call this to update all views observing this value
            objectWillChange.send()
        }
    }
    
    @Published var player2 = Player(playerNumber: .player2){
        didSet {
            // when an observed value is changed, call this to update all views observing this value
            objectWillChange.send()
        }
    }
    @Published var round = Round(){
        didSet {
            // when an observed value is changed, call this to update all views observing this value
            objectWillChange.send()
        }
    }

}

// class with published variables so subscribers can monitor values in these variables
class Player : ObservableObject{
    @Published var score = 0
    @Published var imageName = try! UserDefaults.standard.getObject(forKey: "userImage", castTo: String.self)
    @Published var name = ""
    @Published var playerNumber : DicePlayer
    @Published var isWinner = false
    init(playerNumber: DicePlayer){
        self.playerNumber = playerNumber
    }

}

// class to convert Int to an observable object
class Round : ObservableObject{
    @Published var round = 1
}

// enum to avoid using strings to monitor game state
// store each turn and endgame
enum DicePlayer {
    case player1
    case player2
    case endGame
}

//score structure for persistent storage
struct Score: Codable {
    let id = UUID()
    let name : String
    let score : Int
    let date = Date()
    
    var stringDate : String {
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "dd/MM/YY"

        // Convert Date to String
        return dateFormatter.string(from: Date())
        
    }
}


// 3 errors to avoid using strings
enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

// declare a protocol for userdefaults to conform to
// to adopt functions objectSet and getObject
protocol ObjectSavable {
    func objectSet<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

// extend userdefaults to conform to objectsavable

extension UserDefaults: ObjectSavable {
    func objectSet<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
          // encode custom object using JSON encoder for storage as Data
          let encoder = JSONEncoder()
          do {
              let data = try encoder.encode(object)
              set(data, forKey: forKey)
          } catch {
              throw ObjectSavableError.unableToEncode
          }
      }
    
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        // decode custom object using JSON decoder from Data for representation in chart
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

// enum to avoid using strings to monitor chart sort state
enum ChartView{
    case byDate
    case byName
}

