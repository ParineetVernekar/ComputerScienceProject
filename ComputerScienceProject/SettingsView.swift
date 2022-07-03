//
//  SettingsView.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 03/07/2022.
//

import SwiftUI

struct SettingsView: View {
    var scores : [Score] = []
    var images = ["adventurer","alchemy","swordsman","assasin", "crossbow"]
    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor.init(named: "Background")!)
                .ignoresSafeArea()
            HStack {
                VStack {
                    VStack {
                        HStack {
                            Text("Settings")
                                .font(.title)
                            Spacer()
                        }
    //                    Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Button {
                            do{
                                // store empty array in scores to reset data
                                try UserDefaults.standard.objectSet(scores, forKey: "scores")

                            } catch{
                                print(error.localizedDescription)
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.init(uiColor: UIColor.init(named: "Secondary")!))
                                    .frame(width:120, height:30)
                                Text("Reset all data")
                                    .foregroundColor(            Color.init(uiColor: UIColor.init(named: "Text")!)
                                    )
                            }
                        }
                        Spacer()
                    }
                    
                    HStack{
                        //allow choice of user images
                        ForEach(images, id: \.self) { image in
                            Button {
                                print("\(image)")
                                do{
                                    try UserDefaults.standard.objectSet(image, forKey: "userImage")

                                } catch{
                                    print(error.localizedDescription)
                                }
                            } label: {
                                Image("\(image)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:60)
                            
                            }
                            
                        }
                        Spacer()
                    }
                    Spacer()
                }
                Spacer()
                //vertical line to separate settings from rules
                Divider()
                    .background(.black)
                HStack {
                    VStack(alignment: .leading) {
                        // show rules in strings
                        Text("Rules")
                            .font(.title)
                        Text("1. Double numbers get +5 points")
                        Text("2. Double sixes get +5 points")
                        Text("3. Top 2 largest numbers get added to score")
                        Spacer()
                        Text("Icons made by max.icons from www.flaticon.com")
                        Spacer()
                    }
                    .padding(.top)

                    
                    Spacer()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        
    }
}
