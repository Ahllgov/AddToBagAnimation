//
//  AddToBagAnimationApp.swift
//  AddToBagAnimation
//
//  Created by Магомед Ахильгов on 20.06.2022.
//

import SwiftUI

@main
struct AddToBagAnimationApp: App {
    
    @StateObject var homeData = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(homeData)
        }
    }
}
