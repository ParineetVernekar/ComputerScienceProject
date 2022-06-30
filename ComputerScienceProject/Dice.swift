//
//  Dice.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 28/06/2022.
//

import SwiftUI

struct Dice:View{
    @EnvironmentObject var settings : PlayerSettings
    
    @State var number1 = 0
    @State var number2 = 0
    @State var number3 = 0
    @State var rolls = 0
    var player: DicePlayer
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
                                print("TAPPED")
                                if turn == player && settings.round.round < 7{
                                    rolls += 1
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
                                    print("TAPPED")
                                    if turn == player && settings.round.round < 7{
                                        rolls += 1
                                        updateScore()
                                    }
                                   
                                    
                                }
                        )
                    
                    DiceNumber(finalNumber: $number3, player: player, turn: $turn)
                        .padding(.leading, 5)

                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    print("TAPPED")
                                    if turn == player && settings.round.round < 7{
                                        rolls += 1
                                        updateScore()
                                    }
                                }
                        )
                    
                }            .padding(.top)

            }
        }
    }
    
    func updateScore(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if rolls == 3{
                if turn == .player1{
                    if number1 == number2 || number1 == number3 || number2 == number3 {
                        settings.player1.score += 5
                        print("double number!")
                    } else if (number1 == 6 && number2 == 6) ||  (number2 == 6 && number3 == 6) || (number1 == 6 && number3 == 6) {
                        settings.player1.score += 6
                        print("double 6!")
                    } else if ((number1 > number2) && (number1 > number3)){
                        print("number 1 largest!")
                        settings.player1.score += number1
                    } else if ((number2 > number1) && (number2 > number3)){
                        print("number 2 largest!")

                        settings.player1.score += number2
                    } else if ((number3 > number2) && (number3 > number1)){
                        print("number 3 largest!")

                        settings.player1.score += number3
                    }
                    
                    if ((number1 > number2)&&(number1 < number3)){
                        print("number 1 middle!")

                        settings.player1.score += number1
                    } else if ((number1 < number2)&&(number1 > number3)){
                        print("number 1 middle!")

                        settings.player1.score += number1
                    } else if ((number2 > number1)&&(number2 < number3)){
                        print("number 2 middle!")

                        settings.player1.score += number2
                    } else if ((number2 < number1)&&(number2 > number3)){
                        print("number 2 middle!")

                        settings.player1.score += number2
                    } else if ((number3 > number2)&&(number1 < number1)){
                        print("number 3 middle!")
                        settings.player1.score += number3
                    } else if ((number3 < number2)&&(number1 > number1)){
                        print("number 3 middle!")

                        settings.player1.score += number3
                    }
                    print(settings.player1.score)

                    rolls = 0

                } else if turn == .player2{
                    if number1 == number2 || number1 == number3 || number2 == number3 {
                        settings.player2.score += 5
                        print("double number!")
                    } else if (number1 == 6 && number2 == 6) ||  (number2 == 6 && number3 == 6) || (number1 == 6 && number3 == 6) {
                        settings.player2.score += 6
                        print("double 6!")
                    } else if ((number1 > number2) && (number1 > number3)){
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
                    print(settings.player2.score)

                    rolls = 0

                }
                if turn == .player1{
                    turn = .player2
                } else if turn == .player2{
                    turn = .player1
                    if settings.round.round == 6{turn = .endGame} else{
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
    @EnvironmentObject var settings : PlayerSettings
    @State private var isRotated = false

    @State var number : Int = 0
    @Binding var finalNumber : Int
    var player : DicePlayer
    @Binding var turn : DicePlayer

    @State private var rotation = 0.0
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
        .rotationEffect(Angle.degrees(isRotated ? 360 : 0))
        .animation(animation, value: isRotated)
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    if (turn == player) && settings.round.round < 7{
                        self.isRotated.toggle()
                        delay()
                    }
                }
        )
    }
    
    func delay(){
            finalNumber = Int.random(in: 1...6)
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        self.number = Int.random(in:1...6)
        self.number = finalNumber

            print(finalNumber)
    }
}
