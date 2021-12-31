//
//  ButtonStyleBootCamp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 31.12.2021.
//

import SwiftUI

/*
    DefaultButtonStyle
    PlainButtonStyle
 */

struct FrenchBoutonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

struct ButtonStyleBootCamp: View {
    @State private var bouton = false
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                bouton.toggle()
            } label: {
                Text("Retrouvailles")
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
            }
            .buttonStyle(FrenchBoutonStyle())

            Spacer()
        }
        // MARK: Changing padding and background order :?
        .padding(.horizontal, 20)
        .padding(.top, 0)
        .background(Color.yellow)
    }
}

struct ButtonStyleBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootCamp()
    }
}
