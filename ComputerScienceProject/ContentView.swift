//
//  ContentView.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 23/06/2022.
//

import SwiftUI

struct ContentView: View {
    // orientation to store current device orientation
    @State private var orientation = UIDeviceOrientation.unknown
    // to store if view is presented or not
    @State var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(uiColor: UIColor(named: "Background")!)
                    .ignoresSafeArea()
                VStack {
                    //Start button
                    NavigationLink(
                        destination: RotateScreen(rootIsActive: $isActive),
                        isActive: self.$isActive
                    ) {
                        Text("Start Game")
                            .foregroundColor(Color.init(uiColor: UIColor(named: "Text")!))
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.init(uiColor: UIColor(named: "Secondary")!))
                            )
                    }
                    .isDetailLink(false)
                    
                    
                }
                VStack{
                    HStack{
                        Spacer()
                        //Leaderboard navigation button
                        NavigationLink(destination: Leaderboard( shouldPopToRootView: $isActive)) {
                            Image(systemName: "chart.bar.xaxis")                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                        //Settings navigation button
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)

                        }
                        
                    }
                    Spacer()
                }
                .padding(.top,10)
                
                //Images for decoration
                Image("crossbow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:120)
                    .offset(x:-280, y:50)
                Image("swordsman")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:120)
                    .offset(x:250, y:-80)
                Image("adventurer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100)
                    .offset(x:-160, y:-80)
                Image("alchemy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:120)
                    .offset(x:-60, y:100)
                Image("assasin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:180)
                    .offset(x:160, y:90)
                
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
