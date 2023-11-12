//
//  Xand0GameApp.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 08/11/23.
//

import SwiftUI

@main
struct Xand0GameApp: App {
    
    @AppStorage("yourName") var yourName = ""
    @StateObject var game = GameService()
    
    var body: some Scene {
        WindowGroup {
            if yourName.isEmpty {
                yourNameView()
            } else{
                StartView(yourName: yourName)
                    .environmentObject(game)
            }
        }
    }
}
