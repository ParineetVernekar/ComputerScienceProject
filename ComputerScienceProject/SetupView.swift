//
//  SetupView.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 27/06/2022.
//

import SwiftUI

struct SetupView: View {
    
    @StateObject var settings = PlayerSettings()

    @FocusState private var usernameFieldIsFocused: Bool

    var body: some View {
        
        ZStack {
            Color.init(uiColor: UIColor(named:"Background")!)
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Text("Player 1")
                                .padding(.leading)
                                .font(.title3)
                            Spacer()
                        }
                        TextField("Player 1", text: $settings.player1.name)
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading, 10)
                            .focused($usernameFieldIsFocused)
                        
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Text("Player 2")
                                .padding(.leading)
                                .font(.title3)
                                

                            Spacer()
                        }
                        TextField("Player 2", text: $settings.player2.name)
                            .textFieldStyle(.roundedBorder)
                            .padding(.leading, 10)
                    }

                }
                
               
                NavigationLink(destination: GameScreen(round: settings.round, player1: settings.player1, player2: settings.player2)            .environmentObject(settings)
) {
                    Text("Next")
                        .foregroundColor(Color.init(uiColor: UIColor(named: "Text")!))
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.init(uiColor: UIColor(named: "Secondary")!))
                        )
                }
                .onAppear{
                    usernameFieldIsFocused.toggle()
                
                }

            }
        }
        
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
