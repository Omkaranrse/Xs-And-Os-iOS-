//
//  GameService.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 12/11/23.
//

import Foundation
import SwiftUI

@MainActor
class GameService : ObservableObject {
    @Published var player1 = Player(gamePiece: .x, name: "Player 1", moves: [])
    @Published var player2 = Player(gamePiece: .o, name: "Player 2", moves: [])
    @Published var possibleMoves = Move.all
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    @Published var isThinking = false
    
    var gameType = GameType.single
    
    var currentPlayer : Player {
        if player1.isCurrent {
            return player1
        } else {
            return player2
        }
    }
    
    var gameStarted : Bool {
        player1.isCurrent || player2.isCurrent
    }
    
    var boardDisabled : Bool {
        gameOver || !gameStarted || isThinking
    }
    
    func setUpGame(gameType : GameType, player1Name : String, player2Name : String){
        switch gameType {
        case .single:
            self.gameType = .single
            player2.name = player2Name
        case .bot:
            self.gameType = .bot
            player2.name = UIDevice.current.name
        case .peer:
            self.gameType = .peer
        case .undertermind:
            break
        }
        player1.name = player1Name
    }
    
    func reset(){
        player1.isCurrent = false
        player2.isCurrent = false
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Move.all
        gameBoard = GameSquare.reset
    }
    
    func updateMoves(index : Int){
        if player1.isCurrent {
            player1.moves.append(index + 1)
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index + 1)
            gameBoard[index].player = player2
        }
    }
    
    func checkIfWinner() {
        if player1.isWinner || player2.isWinner{
            gameOver = true
        }
    }
    
    func toggleCurrent(){
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    func makemove(at index : Int){
        if gameBoard[index].player == nil {
            withAnimation {
                updateMoves(index: index)
            }
            checkIfWinner()
            
            if !gameOver {
                if let matchingIndex = possibleMoves.firstIndex(where: { $0 == (index + 1)}){
                    possibleMoves.remove(at: matchingIndex)
                }
                toggleCurrent()
                
                if gameType == .bot && currentPlayer.name == player2.name {
                    Task{
                        await deviceMove()
                    }
                }
            }
            if possibleMoves.isEmpty{
                gameOver = true
            }
        }
    }
    
    func deviceMove() async {
        isThinking.toggle()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        if let move = possibleMoves.randomElement(){
            if let matchingIndex = Move.all.firstIndex(where: { $0 == move }) {
                makemove(at: matchingIndex)
            }
        }
        isThinking.toggle()
    }
}
