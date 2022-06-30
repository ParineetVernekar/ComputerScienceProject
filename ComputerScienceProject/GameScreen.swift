//
//  GameScreen.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 24/06/2022.
//

import SwiftUI

struct GameScreen: View {
//    @EnvironmentObject var settings : PlayerSettings
    @ObservedObject var player1 : Player
    @ObservedObject var player2 : Player
    
    @State var player1Dice1 = 0
    @State var player1Dice2 = 0
    @State var player1Dice3 = 0
    
    @State var player1Rolls = 0
    
    @State var player2Dice1 = 0
    @State var player2Dice2 = 0
    @State var player2Dice3 = 0
    
    @State var player2Rolls = 0

    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor(named: "Background") ?? UIColor.red)
                .ignoresSafeArea()
            HStack{
                HStack{
                    
                    VStack {
                        ScoreView(player: player1)
                        Dice(player: .player1)
                    }

                    Spacer()
//                    VStack {
//                        ScoreView(player: settings.player2)
//                        DiceNumber(number: $player2Dice1, rolls: $player2Rolls, player: settings.player2)
//                        HStack {
//                            DiceNumber(number: $player2Dice2, rolls: $player2Rolls, player: settings.player2)
//                            DiceNumber(number: $player2Dice3, rolls: $player2Rolls, player: settings.player2)
//
//                        }.padding(.top)
//                    }
                }
            }
            .padding()
        }
        
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(player1: Player(), player2: Player())
            .environmentObject(PlayerSettings())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct ScoreView: View {
    @ObservedObject var player : Player
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("\(player.name)")
                        .padding([ .leading])
                        .font(.headline)
                    Text("\(player.score)")
                        .font(.subheadline)
                }
                Spacer()
                Image("\(player.imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:50)
            }
            
        }
        .background(
            RoundedRectangle(cornerRadius: 9)
                .fill(Color.init(uiColor: UIColor(named: "Secondary")!))
                .frame(width:150, height: 50)
            
        )
        .frame(width:150, height: 50)
    }
}
