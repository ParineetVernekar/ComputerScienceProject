//
//  Leaderboard.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 03/07/2022.
//

import SwiftUI
import Charts

struct Leaderboard: View {
    @Environment(\.dismiss) var dismiss
    @Binding var shouldPopToRootView : Bool

    @State var scores : [Score] = [Score(name: "Pari", score: 40), Score(name: "PV", score: 15),Score(name: "Pari", score: 40)]
    
    @State var chartView = ChartView.byName
    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor(named: "Background") ?? UIColor.red)
                .ignoresSafeArea()
            VStack {
                HStack{
                    // show context menus
                    // for view types
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.init(uiColor: UIColor.init(named: "Secondary")!))
                            .frame(width:60, height:30)
                        Text("View")
                            .contextMenu {
                                Button {
                                    chartView = .byName
                                } label: {
                                    Label("By name", systemImage: "globe")
                                }
                                
                                Button {
                                    chartView = .byDate
                                } label: {
                                    Label("By date", systemImage: "location.circle")
                                }
                            }
                    }
                    
                    // show context menus
                    // for sorting
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.init(uiColor: UIColor.init(named: "Secondary")!))
                            .frame(width:60, height:30)
                        Text("Sort")
                            .contextMenu {
                                Button {
                                    sortByScore()
                                } label: {
                                    Label("By score", systemImage: "globe")
                                }
                                
                                Button {
                                    sortByName()
                                } label: {
                                    Label("By name", systemImage: "location.circle")
                                }
                            }
                    }
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                    }

                }
                .padding()
                // show chart based on state values
                // if by name, use name in x, else use y
                Chart(scores, id: \.id) {
                            BarMark(
                                x: .value(chartView == .byName ? "Name" : "Date", chartView == .byName ? $0.name : $0.stringDate),
                                y: .value("Score", $0.score),
                                width: 7.0
                            )
                            .foregroundStyle(
                                           by: .value(chartView == .byName ? "Name" : "Date", chartView == .byName ? $0.name : $0.stringDate)
                                       )
                        }
                
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            }.onAppear{
                do{
                    // get scores from userdefaults to show in chart
                    scores = try UserDefaults.standard.getObject(forKey: "scores", castTo: [Score].self)
                    
                } catch{
                    print(error.localizedDescription)
                }
        }                .navigationBarBackButtonHidden(true)

        }
    }
    
    
    
    //bubble sort
    func sortByName(){
        let lastPos = scores.count - 1
        var swap = true
        while swap == true {
            swap = false
            //for every item apart from last
            for i in 0..<lastPos {
                if scores[i].name > scores[i + 1].name {
                    // store i + 1 in temp
                    let temp = scores [i + 1]
                    // update i + 1 to i
                    scores [i + 1] = scores[i]
                    // update i to temp
                    scores[i] = temp
                    // set swap flag to true
                    swap = true
                }
            }
        }
    }
    
    //same as above apart from sorting by score not name
    
    func sortByScore(){
        let lastPos = scores.count - 1
        var swap = true
        while swap == true {
            swap = false
            for i in 0..<lastPos {
                if scores[i].score > scores[i + 1].score {
                    let temp = scores [i + 1]
                    scores [i + 1] = scores[i]
                    scores[i] = temp
                    
                    swap = true
                }
            }
        }
    }
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard( shouldPopToRootView: .constant(true))
            .navigationTitle("Welcome")

    }
}
