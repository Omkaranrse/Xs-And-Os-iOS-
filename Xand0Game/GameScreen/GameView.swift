//
//  GameView.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 12/11/23.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("End Game"){
                    dismiss()
                }.buttonStyle(.bordered)
            }
        }
        .navigationTitle("Xs And Os")
        .isNavigationStack()
    }
}

#Preview {
    GameView()
}
