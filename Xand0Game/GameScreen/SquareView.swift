//
//  SquareView.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 13/11/23.
//

import SwiftUI

struct SquareView: View {
    
    @EnvironmentObject var game : GameService
    let index : Int
    
    var body: some View {
        Button(action: {
            if !game.isThinking { 
                game.makemove(at: index)
            }
        }, label: {
            game.gameBoard[index].image
                .resizable()
                .frame(width: 100, height: 100)
        })
        .disabled(game.gameBoard[index].player != nil)
        .foregroundStyle(Color.primary)
    }
}

#Preview {
    SquareView(index: 1)
        .environmentObject(GameService())
}
