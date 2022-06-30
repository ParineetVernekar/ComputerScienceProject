//
//  GameScreen.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 24/06/2022.
//

import SwiftUI

struct GameScreen: View {
    @ObservedObject var round : Round
    @ObservedObject var player1 : Player
    @ObservedObject var player2 : Player
    @State var turn = DicePlayer.player1
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
//                    if turn == .player1{
                        VStack {
                            HStack {
                                ScoreView(player: player1, turn: $turn)
                                Spacer()
                            }
                            Dice(player: .player1, turn: $turn)
                        }
//                    }
                    
                    Spacer()
                    VStack {
                        Text("Round \(round.round)")
                            .font(.title)
                            .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.init(uiColor: UIColor(named: "Secondary")!))
                            .frame(width:150, height: 50)
                        )

                        Spacer()
                    }
                    .padding(.top, 15)
                    Spacer()
//                    if turn == .player2{
                        VStack {
                            HStack {
                                Spacer()
                                ScoreView(player: player2, turn: $turn)
                            }
                            Dice(player: .player2, turn: $turn)
                        }
//                    }
                }
            }
            .padding()
        }
        
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(round: Round(), player1: Player(playerNumber: .player1), player2: Player(playerNumber: .player2))
            .environmentObject(PlayerSettings())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct ScoreView: View {
    @ObservedObject var player : Player
    @Binding var turn : DicePlayer
    
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
                .fill(turn == player.playerNumber ? Color.green : Color.init(uiColor: UIColor(named: "Secondary")!))
                .frame(width:150, height: 50)
            
        )
        .frame(width:150, height: 50)
    }
}
