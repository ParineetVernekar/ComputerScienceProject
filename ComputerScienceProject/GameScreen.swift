//
//  GameScreen.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 24/06/2022.
//

import SwiftUI

struct GameScreen: View {
    // observe values of round, player1 and player2 passed from parent
    // on value change, view updates
    @ObservedObject var round : Round
    @ObservedObject var player1 : Player
    @ObservedObject var player2 : Player
    
    //store current turn using DicePlayer enum
    @State var turn = DicePlayer.player1
    
    // store way of presentation leaderboard (e.g modal)
    @Environment(\.presentationMode) var presentationMode
    
    // to store if view is presented or not
    @Binding var rootIsActive : Bool

    // store whether leaderboard view should be presented or not
    @State var showLeaderboard = false

    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor(named: "Background") ?? UIColor.red)
                .ignoresSafeArea()
            HStack{
                HStack{
                    // player1 side
                        VStack {
                            HStack {
                                ScoreView(player: player1, turn: $turn)
                                Spacer()
                            }
                            Dice(player: .player1, turn: $turn)
                        }
                    Spacer()
                    VStack {
                        // show round number
                        Text(turn == .endGame ? "Game over!" : "Round \(round.round)")
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
                    // player2 side
                        VStack {
                            HStack {
                                Spacer()
                                ScoreView(player: player2, turn: $turn)
                            }
                            Dice(player: .player2, turn: $turn)
                        }
                }
            }
            .padding()
            
            //when game over
            // overlay game view with finish view and opacity
            
            if turn == .endGame{
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.3)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width/2, height: 200)
                    .padding(.top, 20)
                    VStack {
                        HStack {
                            HStack {
                                Image("\(player1.imageName)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:75)
                                VStack {
                                    HStack {
                                        // show winner with emoji
                                        Text("\(player1.name) \(player1.isWinner ? "🎉":"")")
                                            .font(.title)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("\(player1.score)")
                                        Spacer()
                                    }

                                }
                            }
                            Spacer()
                            HStack {
                                VStack {
                                    HStack {
                                        Spacer()
                                        // show winner with emoji
                                        Text("\(player2.name) \(player2.isWinner ? "🎉":"")")
                                            .font(.title)
                                    }

                                    HStack {
                                        Spacer()
                                        Text("\(player2.score)")

                                    }
                                }
                                Image("\(player2.imageName)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:75)
                            }
                        }
                        .padding()
                        
                        HStack{
                            // home navigation
                            // pop to root of navigation stack
                            Button{
                                 self.rootIsActive = false
                            } label:{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.init(uiColor: UIColor.init(named: "Background")!))
                                        .frame(width:70, height:30)
                                    Text("Home")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                }
                                
                            }
                            // leaderboard navigation

                            Button {
                                showLeaderboard.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.init(uiColor: UIColor.init(named: "Background")!))
                                        .frame(width:120, height:30)
                                    Text("Leaderboard")
                                        .font(.headline)

                                        .foregroundColor(Color.white)
                                }                            }.sheet(isPresented: $showLeaderboard) {
                                    Leaderboard( shouldPopToRootView: self.$rootIsActive)
                            }
                        }


                        Spacer()
                    }
                    .padding(.top, 60)

                    
                }
                .frame(width: UIScreen.main.bounds.width/2.5, height: 260)
                .navigationBarBackButtonHidden(true)

            }

        }
        
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(round: Round(), player1: Player(playerNumber: .player1), player2: Player(playerNumber: .player2), rootIsActive: .constant(true))
            .environmentObject(PlayerSettings())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

// show current score
struct ScoreView: View {
    @ObservedObject var player : Player
    @Binding var turn : DicePlayer
    // binding to respond to turn updates
    
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
