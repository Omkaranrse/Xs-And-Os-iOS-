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
    @AppStorage("yourName") var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus : Bool
    @State private var startGame : Bool = false
    @State private var changeName : Bool = false
    @State private var newName = ""
    
    init(yourName : String){
        self.yourName = yourName
    }
    
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
                        TextField("Opponent Name", text: $opponentName)
                    case .bot:
                        EmptyView()
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
                        gameType == .single && opponentName.isEmpty
                    )
                    Image("LaunchScreen")
                    Text("Your name is \(yourName)")
                    Button("Change my name"){
                        changeName.toggle()
                    }
                    .buttonStyle(.bordered)
                }
                Spacer()
                
            }
            .padding()
            .navigationTitle("Xs And Os")
            .fullScreenCover(isPresented: $startGame){
                GameView()
            }
            .alert("Change Name", isPresented: $changeName, actions: {
                TextField("New Name", text: $newName)
                Button("OK", role: .destructive){
                    yourName = newName
//                    exit(-1)
                }
                Button("Cancel", role: .cancel) {}
            }, message: {
                Text("Tapping on the OK button will quit the application so you can relaunch to use your changed name.")
            })
            .isNavigationStack()
        }
    }
}

#Preview {
    StartView(yourName: "Omkar")
        .environmentObject(GameService())
}
