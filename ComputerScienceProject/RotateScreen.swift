//
//  RotateScreen.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 23/06/2022.
//

import SwiftUI

struct RotateScreen: View {
    // store current orientation
    @State private var orientation = UIDeviceOrientation.unknown
    // to store if view is presented or not
    @Binding var rootIsActive : Bool

    var body: some View {
        ZStack {
            Color.init(uiColor: UIColor(named: "Background")!)
                .ignoresSafeArea()
            VStack {
                //if portrait, ask user to rotate (show view)
                if orientation.isPortrait{
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:150)
                        .padding(.bottom)
                    Text("Rotate your screen")
                        .font(.headline)
                    // else show setup view
                } else {
                    SetupView( rootIsActive: $rootIsActive)
                }
            }
            .foregroundColor(Color.init(uiColor: UIColor(named: "Text")!))
            //onrotate update orientation variable
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}


struct RotateScreen_Previews: PreviewProvider {
    static var previews: some View {
        RotateScreen(rootIsActive: .constant(true))
            .environmentObject(PlayerSettings())
    }
}


// to detect when device orientation has changed
struct RotationModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A  wrapper to make the modifier easier to use
// to use like .onRotate{ do stuff }
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(RotationModifier(action: action))
    }
}
