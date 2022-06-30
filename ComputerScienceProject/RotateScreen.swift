//
//  RotateScreen.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 23/06/2022.
//

import SwiftUI

struct RotateScreen: View {
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor(named: "Background")!)
                .ignoresSafeArea()
            VStack {
                if orientation.isPortrait{
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150)
                        .padding(.bottom)
                    Text("Rotate your screen")
                        .font(.headline)
                } else if orientation.isLandscape  || orientation.isFlat{
                    SetupView()
                }  else {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150)
                        .padding(.bottom)
                    Text("Rotate your screen")
                        .font(.headline)
                }
            }
            .foregroundColor(Color.init(uiColor: UIColor(named: "Text")!))
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}
//
//struct GameStartView: View{
//    @EnvironmentObject var player1 : Player1Settings
//    @EnvironmentObject var player2 : Player2Settings
//
//    var body: some View{
//        let _ = print(player1.name)
//        let _ = print(player2.name)
//
//
//        HStack{
//            Spacer()
//            VStack{
//                Image("swordsman")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width:200)
//                Text("\(player1.name)")
//            }
//            VStack{
//                Text("VS")
//                    .font(.title)
//                NavigationLink {
//                    GameScreen()
//                        .environmentObject(player1)
//                        .environmentObject(player2)
//                } label: {
//                    Text("Start")
//                     .foregroundColor(Color.init(uiColor: UIColor(named: "Text")!))
//                     .padding(10)
//                     .background(
//                     RoundedRectangle(cornerRadius: 10)
//                         .fill(Color.init(uiColor: UIColor(named: "Secondary")!))
//                     )
//                }
//
//            }
//            VStack{
//                Image("crossbow")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width:200)
//                Text("\(player2.name)")
//
//            }
//            Spacer()
//
//        }
//
//    }
//}


struct RotateScreen_Previews: PreviewProvider {
    static var previews: some View {
        RotateScreen()
            .environmentObject(PlayerSettings())
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
