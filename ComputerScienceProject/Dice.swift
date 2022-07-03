//
//  Dice.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 28/06/2022.
//

import SwiftUI

struct Dice:View{
    @EnvironmentObject var settings : PlayerSettings
    
    // inital dice starting values
    @State var number1 = 1
    @State var number2 = 1
    @State var number3 = 1
    //store number of rolls in this go
    @State var rolls = 0
    
    // store player for comparison for adding
    var player: DicePlayer
    
    // store current turn
    @Binding var turn : DicePlayer

    var body: some View{
        ZStack {
            Color.init(uiColor: UIColor.init(named: "Background")!)
                .ignoresSafeArea()
            VStack{
                DiceNumber(finalNumber: $number1, player: player, turn: $turn)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                // if turn = set player and game isn't over
                                if turn == player && settings.round.round < 7{
                                    //update rolls
                                    rolls += 1
                                    //run updateScore
                                    updateScore()
                                }
                            }
                    )
                HStack{
                    DiceNumber(finalNumber: $number2, player: player, turn: $turn)
                        .padding(.trailing, 5)
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    // if turn = set player and game isn't over
                                    if turn == player && settings.round.round < 7{
                                        //update rolls
                                        rolls += 1
                                        //run updateScore
                                        updateScore()
                                    }
                                }
                        )
                    
                    DiceNumber(finalNumber: $number3, player: player, turn: $turn)
                        .padding(.leading, 5)

                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    // if turn = set player and game isn't over
                                    if turn == player && settings.round.round < 7{
                                        //update rolls
                                        rolls += 1
                                        //run updateScore
                                        updateScore()
                                    }
                                }
                        )
                    
                }            .padding(.top)

            }
        }
    }
    
    func updateScore(){
        // after 0.1 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // if all 3 die have been rolled
            if rolls == 3{
                //if it is player 1
                if turn == .player1{
                    
                    // if there is a double 6
                    if (number1 == 6 && number2 == 6) ||  (number2 == 6 && number3 == 6) || (number1 == 6 && number3 == 6) {
                        // add 6
                        settings.player1.score += 6
                        print("double 6!")
                    } else if number1 == number2 || number1 == number3 || number2 == number3 {
                        // if there is a double number, add 5
                        settings.player1.score += 5
                        print("double number!")
                    }
                    
                    // if number 1 is largest, add number1
                    if ((number1 > number2) && (number1 > number3)){
                        print("number 1 largest!")
                        settings.player1.score += number1
                        
                        // if number 2 is largest, add number2
                    } else if ((number2 > number1) && (number2 > number3)){
                        print("number 2 largest!")
                        settings.player1.score += number2
                        
                        // if number 3 is largest, add number3
                    } else if ((number3 > number2) && (number3 > number1)){
                        print("number 3 largest!")
                        settings.player1.score += number3
                    }
                    
                    // add number1 if it is middle number
                    if ((number1 > number2)&&(number1 < number3)){
                        print("number 1 middle!")

                        settings.player1.score += number1
                    } else if ((number1 < number2)&&(number1 > number3)){
                        print("number 1 middle!")

                        settings.player1.score += number1
                        
                        // add number2 if it is middle number
                    } else if ((number2 > number1)&&(number2 < number3)){
                        print("number 2 middle!")

                        settings.player1.score += number2
                    } else if ((number2 < number1)&&(number2 > number3)){
                        print("number 2 middle!")

                        settings.player1.score += number2
                        
                        // add number3 if it is middle number
                    } else if ((number3 > number2)&&(number1 < number1)){
                        print("number 3 middle!")
                        settings.player1.score += number3
                    } else if ((number3 < number2)&&(number1 > number1)){
                        print("number 3 middle!")

                        settings.player1.score += number3
                    }
                    rolls = 0

                } else if turn == .player2{
                    //same for player 2
                    // separate so that individual player can be accessed
                    if (number1 == 6 && number2 == 6) ||  (number2 == 6 && number3 == 6) || (number1 == 6 && number3 == 6) {
                        settings.player2.score += 6
                        print("double 6!")
                    } else if number1 == number2 || number1 == number3 || number2 == number3 {
                        settings.player2.score += 5
                        print("double number!")
                    }  
                    
                    if ((number1 > number2) && (number1 > number3)){
                        print("number 1 largest!")
                        settings.player2.score += number1
                    } else if ((number2 > number1) && (number2 > number3)){
                        print("number 2 largest!")

                        settings.player2.score += number2
                    } else if ((number3 > number2) && (number3 > number1)){
                        print("number 3 largest!")

                        settings.player2.score += number3
                    }
                    
                    if ((number1 > number2)&&(number1 < number3)){
                        print("number 1 middle!")

                        settings.player2.score += number1
                    } else if ((number1 < number2)&&(number1 > number3)){
                        print("number 1 middle!")

                        settings.player2.score += number1
                    } else if ((number2 > number1)&&(number2 < number3)){
                        print("number 2 middle!")

                        settings.player2.score += number2
                    } else if ((number2 < number1)&&(number2 > number3)){
                        print("number 2 middle!")

                        settings.player2.score += number2
                    } else if ((number3 > number2)&&(number1 < number1)){
                        print("number 3 middle!")
                        settings.player2.score += number3
                    } else if ((number3 < number2)&&(number1 > number1)){
                        print("number 3 middle!")

                        settings.player2.score += number3
                    }

                    rolls = 0

                }
                
                //switch turns
                // from player1 to 2
                if turn == .player1{
                    turn = .player2
                } else if turn == .player2{
                    // from player2 to 1
                    turn = .player1
                    
                    // if final round complete and scores not equal
                    if (settings.round.round == 6) && (settings.player1.score != settings.player2.score){
                        //endgame
                        turn = .endGame
                        if(settings.player1.score > settings.player2.score){
                            // set winner value
                            settings.player1.isWinner = true
                            // store winner score and name in userdefaults
                            let score = Score(name: settings.player1.name, score: settings.player1.score)
                            let userDefaults = UserDefaults.standard
                            var scores : [Score] = []
                            do {
                                //by fetching current scores
                                 scores = try userDefaults.getObject(forKey: "scores", castTo: [Score].self)
                                print("scores: \(scores)")
                            } catch {
                                print("ERROR")
                                print("scores during fetch: \(scores)")

                                print(error.localizedDescription)
                            }
                            
                            print("scores before append: \(scores)")
                            
                            //and appending new score
                            scores.append(score)
                            print("scores after append: \(scores)")

                            do{
                                //before restoring in userdefaults
                                try userDefaults.objectSet(scores, forKey: "scores")

                            } catch{
                                print(error.localizedDescription)
                            }
                         
                          
                            
                        } else{
                            //repeat for player2
                            settings.player2.isWinner = true
                           
                            let score = Score(name: settings.player2.name, score: settings.player2.score)
                            
                            let userDefaults = UserDefaults.standard
                            var scores : [Score] = []
                            do {
                                 scores = try userDefaults.getObject(forKey: "scores", castTo: [Score].self)
                                for score in scores{
                                    print(score.name)
                                    print(score.score)
                                }
                            } catch {
                                print("ERROR")
                                print("scores during fetch: \(scores)")

                                print(error.localizedDescription)
                            }
                            
                            print("scores before append: \(scores)")
                            scores.append(score)
                            print("scores after append: \(scores)")

                            do{
                                try userDefaults.objectSet(scores, forKey: "scores")

                            } catch{
                                print(error.localizedDescription)
                            }
                            

                        }
                        
                    } else{
                        //if not end then increment round by 1
                        settings.round.round += 1
                    }

                }
            }
           
        }
        
        print(settings.player1.score)

    }
}

//struct Dice_Previews: PreviewProvider {
//    static var previews: some View {
//        Dice(player: .player1, turn: DicePlayer.player1)
//
//    }
//}

struct DiceNumber: View {
    // store playersettings in environment object
    @EnvironmentObject var settings : PlayerSettings
    
    // isRotated boolean to check if animation run or not
    @State private var isRotated = false

    // store displayed dice number
    @State var number : Int = 0
    //number to submit to parent
    @Binding var finalNumber : Int
    //player to correspond to
    var player : DicePlayer
    //current turn
    @Binding var turn : DicePlayer

    // custom animation for spin
    // spins 3 times
    var animation: Animation {
        Animation.linear
            .repeatCount(3,autoreverses: false)
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 70,height: 70)
            Group{
                // different views for different numbers
                // to look like dice
                if number == 6{
                    HStack {
                        VStack {
                            Circle()
                                .frame(width:12)
                            
                            Circle()
                                .frame(width:12)
                            Circle()
                                .frame(width:12)
                        }
                        Spacer()
                        VStack {
                            Circle()
                                .frame(width:12)
                            Circle()
                                .frame(width:12)
                            Circle()
                                .frame(width:12)
                        }
                    }
                } else if number == 1{
                    Circle()
                        .frame(width:12)
                } else if number == 2{
                    VStack {
                        HStack {
                            Spacer()
                            Circle()
                                .frame(width:12)
                        }
                        HStack {
                            Circle()
                                .frame(width:12)
                            Spacer()
                        }
                    }
                    
                } else if number == 3{
                    VStack {
                        HStack {
                            Spacer()
                            Circle()
                                .frame(width:12)
                        }
                        Circle()
                            .frame(width:12)
                        HStack {
                            Circle()
                                .frame(width:12)
                            Spacer()
                        }
                    }
                } else if number == 4{
                    VStack{
                        HStack{
                            Circle()
                                .frame(width:12)
                            Spacer()
                            Circle()
                                .frame(width:12)
                        }
                        Spacer()
                        HStack{
                            Circle()
                                .frame(width:12)
                            Spacer()
                            Circle()
                                .frame(width:12)
                        }
                    }
                } else if number == 5{
                    VStack{
                        HStack{
                            Circle()
                                .frame(width:12)
                            Spacer()
                            Circle()
                                .frame(width:12)
                        }
                        Circle()
                            .frame(width:12)
                        HStack{
                            Circle()
                                .frame(width:12)
                            Spacer()
                            Circle()
                                .frame(width:12)
                        }
                    }
                } else if number == 0{
                    VStack{
                        
                    }
                }
            }
            .padding(.all, 8)
            .frame(width: 70, height:70)
            
        }
        // add rotation effect
        .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
        // with animation using 3 spin animation
        .animation(animation, value: isRotated)
        // on tap, rotate
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    // only if dice player is equal to current turn and game is not over
                    if (turn == player) && settings.round.round < 7{
                        self.isRotated.toggle()
                        // run roll function
                        roll()
                    }
                }
        )
    }
    
    func roll(){
        // set final number
            finalNumber = Int.random(in: 1...6)
        // iterate through 6 numbers to look like dice
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        //set dice view to final number
        self.number = finalNumber
    }
}
