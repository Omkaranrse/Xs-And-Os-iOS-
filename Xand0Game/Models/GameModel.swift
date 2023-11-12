//
//  GameModel.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 08/11/23.
//

import Foundation

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
