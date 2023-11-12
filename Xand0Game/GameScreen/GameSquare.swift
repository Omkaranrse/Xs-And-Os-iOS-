//
//  GameSquare.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 13/11/23.
//

import Foundation
import SwiftUI

struct GameSquare {
    var id : Int
    var player : Player?
    
    var image : Image {
        if let player = player {
            return player.gamePiece.image
        }else{
            return Image("none")
        }
    }
    
    static var reset : [GameSquare] {
        var squares = [GameSquare]()
        for index in 1...9{
            squares.append(GameSquare(id: index))
        }
        return squares
    }
}
