//
//  TutorialView.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 5.01.2022.
//

import SwiftUI

struct TutorialView: View {
    @StateObject var viewModel = TutorialViewModel()
    
    public var body: some View {
        ZStack {
            Color.blue.opacity(0.3)
            
            VStack(spacing: 20) {
                VStack {
                    TextField("Name", text: .constant(""))
                        .extensionTextFieldView(roundedCornes: 6, startColor: .white, endColor: .purple)
                        .placeTutorialContent(
                            item: viewModel.tutorials[.name],
                            isHidden: !viewModel.activeTutorials.contains(.name)
                        )
                    
                    TextField("Password", text: .constant(""))
                        .extensionTextFieldView(roundedCornes: 6, startColor: .pink.opacity(0.5), endColor: .white.opacity(0.6))
                        .placeTutorialContent(
                            item: viewModel.tutorials[.password],
                            isHidden: !viewModel.activeTutorials.contains(.password)
                        )
                }
                .padding(.horizontal, 30)
                
                HStack {
                    Button { } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
                    }
                    .placeTutorialContent(
                        item: viewModel.tutorials[.login],
                        isHidden: !viewModel.activeTutorials.contains(.login)
                    )
                    
                    Button { } label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
                    }
                    .placeTutorialContent(
                        item: viewModel.tutorials[.signup],
                        isHidden: !viewModel.activeTutorials.contains(.signup)
                    )
                }
                .padding(.horizontal, 24)
            }
            
            Button {
                viewModel.nextTutorial()
            } label: {
                Text("Tutorial")
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 45)
                    .frame(maxWidth: .infinity, alignment: .bottom)
                    .background(Color.cyan)
                    .cornerRadius(8)
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 10)
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}

extension TextField {
    func extensionTextFieldView(roundedCornes: CGFloat, startColor: Color,  endColor: Color) -> some View {
        self
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(roundedCornes)
            .shadow(color: .purple, radius: 10)
    }
}
