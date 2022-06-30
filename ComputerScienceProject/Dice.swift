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
            
            print(settings.player1.score)
        } else {
            settings.player2.score += number1
            settings.player2.score += number2
            settings.player2.score += number3
            
        }
        
        print(settings.player1.score)
    }
    
}

struct Dice_Previews: PreviewProvider {
    static var previews: some View {
        Dice(player: .player1)
    }
}

struct DiceNumber: View {
    @EnvironmentObject var settings : PlayerSettings
    
    @Binding var number : Int
    
    var player : DicePlayer
    @State private var rotation = 0.0
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
        .rotationEffect(.degrees(rotation))
        
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    delay()
                }
        )
    }
    
    func delay(){
        withAnimation {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.number = Int.random(in:1...6)
                for degree in 0...60 {
                    self.rotation = Double(degree)
                }                 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.number = Int.random(in:1...6)
                for degree in 60...120 {
                    self.rotation = Double(degree)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.number = Int.random(in:1...6)
                for degree in 120...180 {
                    self.rotation = Double(degree)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.number = Int.random(in:1...6)
                for degree in 180...240 {
                    self.rotation = Double(degree)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.number = Int.random(in:1...6)
                for degree in 240...300 {
                    self.rotation = Double(degree)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                self.number = Int.random(in:1...6)
                for degree in 300...360 {
                    self.rotation = Double(degree)
                }
                
                
                
            }
            
            //        if player == .player1{
            //            settings.player1.score += number
            //            settings.objectWillChange.send()
            //
            //            print(settings.player1.score)
            //        } else {
            //            settings.player2.score += number
            //        }
        }
    }
}
