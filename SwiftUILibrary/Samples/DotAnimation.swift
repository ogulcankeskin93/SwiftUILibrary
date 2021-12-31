//
//  DotAnimation.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 25.12.2021.
//

import SwiftUI

struct DotAnimation: View {
    enum AnimationState {
        case normal
        case flipped
    }
    
    @State private var dotScale: CGFloat = 1
    @State private var animationState: AnimationState = .normal
    
    var body: some View {
        ZStack {
            
            Color.yellow
            
            Rectangle()
                .fill(.blue)
                .overlay(
                    self.innerContent()
                )
                .mask {
                    GeometryReader { geo in
                        Circle()
                            .frame(width: 100, height: 100)
                            .scaleEffect(dotScale)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .shadow(radius: 10)
                            .offset(y: -60)

                    }
                }
            
            Circle()
                .foregroundColor(.black.opacity(0.01))
                .scaleEffect(dotScale)
                .frame(width: 100, height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .offset(y: -60)
                .onTapGesture {
                    switch animationState {
                    case .normal:
                        withAnimation {
                            dotScale = 12
                            animationState = .flipped
                        }
                    case .flipped:
                        withAnimation {
                            dotScale = 1
                            animationState = .normal
                        }
                    }
                }

        }
        .ignoresSafeArea()

    }
    
    @ViewBuilder
    func innerContent() -> some View {
        VStack(spacing: 10) {
            Image(systemName: "ipad")
                .font(.system(size: 145))
            
            Text("iPad")
                .font(.system(size: 50))
            
        }
        .foregroundColor(.white)
    }
}

struct DotAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DotAnimation()
    }
}
