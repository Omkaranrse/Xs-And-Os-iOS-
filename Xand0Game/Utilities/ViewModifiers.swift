//
//  ViewModifiers.swift
//  Xand0Game
//
//  Created by Omkar Anarse on 08/11/23.
//

import Foundation
import SwiftUI

struct NavStackContainer : ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16, *){
            NavigationStack{
                content
            }
        }else{
            NavigationView{
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

extension View {
    public func isNavigationStack() -> some View{
        return self.modifier(NavStackContainer())
    }
}
