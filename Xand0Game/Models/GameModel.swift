//
//  GameModel.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 08/11/23.
//

import Foundation
import SwiftUI

enum GameType {
    case single, bot, peer, undertermind
    
    var description : String {
        switch self {
        case .single:
            return "Share your iPhone/ipad and play against a friend"
        case .bot:
            return "Play against iPhone/ipad"
        case .peer:
            return "Invaite some one who has this app running to play"
        case .undertermind:
            return ""
        }
    }
}

enum GamePiece : String {
    case x, o
    
    var image : Image {
        Image(self.rawValue)
    }
}

struct Player {
    let gamePiece : GamePiece
    var name : String
    var moves : [Int]
    var isCurrent : Bool = false
    var isWinner : Bool {
        for moves in Move.winningMoves {
            if moves.allSatisfy(self.moves.contains){
                return true
            }
        }
        return false
    }
}

enum Move {
    static var all = [1,2,3,4,5,6,7,8,9]

    static var winningMoves = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
    ]
}
