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

    var player: DicePlayer
    
    var body: some View{
        VStack{
            DiceNumber(number: $number1, player: player)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            print("TAPPED")
                            updateScore()
                        }
                )
              
                
            HStack{
                DiceNumber(number: $number2, player: player)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                print("TAPPED")
                                
                                updateScore()
                            }
                    )
                DiceNumber(number: $number3, player: player)
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                print("TAPPED")
                                
                                updateScore()
                            }
                    )
                
            }
        }
    }
    
    func updateScore(){
        if player == .player1{
            
            settings.player1.score += number1
            settings.player1.score += number2
            settings.player1.score += number3
            
        } else {
            settings.player2.score += number1
            settings.player2.score += number2
            settings.player2.score += number3
            
        }
        
//        print(settings.player1.score)
    }
    
}

struct Dice_Previews: PreviewProvider {
    static var previews: some View {
        Dice(player: .player1)
    }
}

struct DiceNumber: View {
    @EnvironmentObject var settings : PlayerSettings
    @State private var isRotated = false

    @Binding var number : Int
    @State var finalNumber = 0
    var player : DicePlayer
    @State private var rotation = 0.0
    var animation: Animation {
        Animation.linear
//            .delay(1.0)
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
                    self.isRotated.toggle()
                    delay()
                }
        )
    }
    
    func delay(){
        withAnimation {
            finalNumber = Int.random(in: 1...6)
            print(finalNumber)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.number = Int.random(in:1...6)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.number = Int.random(in:1...6)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.number = Int.random(in:1...6)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.number = Int.random(in:1...6)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.number = Int.random(in:1...6)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                self.number = finalNumber
                print(self.number)

            }
            
        }
    }
}
