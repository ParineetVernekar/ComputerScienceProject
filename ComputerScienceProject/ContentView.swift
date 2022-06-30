//
//  ContentView.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 23/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var orientation = UIDeviceOrientation.unknown

    var body: some View {
        NavigationView {
            ZStack {
                Color.init(uiColor: UIColor(named: "Background")!)
                    .ignoresSafeArea()
                VStack {
                    NavigationLink(destination: RotateScreen()) {
                        Text("Start Game")
                            .foregroundColor(Color.init(uiColor: UIColor(named: "Text")!))
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.init(uiColor: UIColor(named: "Secondary")!))
                            )
                    }
                    
                    
                }
                if orientation.isPortrait{
                    Image("crossbow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:120)
                        .offset(x:-80, y:-270)
                    Image("swordsman")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:120)
                        .offset(x:80, y:-150)
                    Image("adventurer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:80)
                        .offset(x:-80, y:-70)
                    Image("alchemy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:120)
                        .offset(x:80, y:100)
                    Image("assasin")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:180)
                        .offset(x:-60, y:220)
                } else {
                    Image("crossbow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:120)
                        .offset(x:-280, y:50)
                    Image("swordsman")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:120)
                        .offset(x:280, y:-80)
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
