//
//  ComputerScienceProjectApp.swift
//  ComputerScienceProject
//
//  Created by Parineet Vernekar on 23/06/2022.
//

import SwiftUI

@main
struct ComputerScienceProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    do{
                        // initialise app by setting the userimage to the swordsman image
                        try UserDefaults.standard.objectSet("swordsman", forKey: "userImage")

                    } catch{
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
