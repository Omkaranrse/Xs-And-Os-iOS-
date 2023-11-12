//
//  StartView.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 08/11/23.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var game : GameService
    @State private var gameType : GameType = .undertermind
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus : Bool
    @State private var startGame : Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Picker("SelectGame", selection: $gameType) {
                    Text("Select Game Type").tag(GameType.undertermind)
                    Text("Two Sharing device").tag(GameType.single)
                    Text("Challenge Your device").tag(GameType.bot)
                    Text("Challenge a friend").tag(GameType.peer)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2))
                Text(gameType.description).padding()
                
                VStack{
                    switch gameType {
                    case .single:
                        VStack{
                            TextField("Your Name", text: $yourName)
                            TextField("Opponent Name", text: $opponentName)
                        }
                    case .bot:
                        TextField("Your Name", text: $yourName)
                    case .peer:
                        EmptyView()
                    case .undertermind:
                        EmptyView()
                    }
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .frame(width: 350)
                if gameType != .peer {
                    Button("Start game"){
                        game.setUpGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                        focus = false
                        startGame.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(
                        gameType == .undertermind ||
                        gameType == .bot && yourName.isEmpty ||
                        gameType == .single && (yourName.isEmpty || opponentName.isEmpty)
                    )
                    Image("LaunchScreen")
                }
                Spacer()
                
            }
            .padding()
            .navigationTitle("Xs And Os")
            .fullScreenCover(isPresented: $startGame){
                GameView()
            }
            .isNavigationStack()
        }
    }
}

#Preview {
    StartView()
        .environmentObject(GameService())
}
