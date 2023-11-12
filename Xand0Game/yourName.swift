//
//  yourName.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 14/11/23.
//

import SwiftUI

struct yourNameView: View {
    
    @AppStorage("yourName") var yourName = ""
    @State private var userName = ""
    
    var body: some View {
        VStack {
            Text("This is the name that will be associated with this device.")
            TextField("Your Name", text: $userName)
                .textFieldStyle(.roundedBorder)
            Button("Set"){
                yourName =  userName
            }
            .buttonStyle(.borderedProminent)
            .disabled(userName.isEmpty)
            Image("LaunchScreen")
            Spacer()
        }
        .padding()
        .navigationTitle("Xs and Os")
        .isNavigationStack()
    }
}

#Preview {
    yourNameView()
}
