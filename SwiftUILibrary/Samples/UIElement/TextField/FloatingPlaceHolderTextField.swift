//
//  FloatingPlaceHolderTextField.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 23.01.2022.
//

import SwiftUI

struct FloatingPlaceHolderTextField: View {
    @Binding var text: String
    let placeHolder: String
    let image: String
    let config: Config
    
    @State private var isTapped = false
    @State private var attemp = CGFloat(0)
    
    var inner: Bool {
        if isTapped {
            return true
        } else {
            if !text.isEmpty {
                return true
            }
        }
        return false
    }
    
    init(text: Binding<String>, placeHolder: String, image: String = "", config: Config = .init()) {
        self._text = text
        self.placeHolder = placeHolder
        self.image = image
        self.config = config
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                TextField(
                    "",
                    text: $text,
                    onEditingChanged: {
                        if $0 {
                            withAnimation(.easeIn) {
                                isTapped = true
                            }
                        }
                    },
                    onCommit: {
                        print("onCommit")
                        withAnimation(.easeOut) {
                            if text.isEmpty {
                                isTapped = false
                                attemp = 0
                            } else {
                                if text.contains("blopmlop") {
                                    attemp += 1
                                } else {
                                    attemp = 0
                                }
                            }
                        }
                    }
                )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.top, inner ? 15 : 0)
                    .background(alignment: .leading) {
                        Text("Boom")
                            .offset(x: -7, y: inner ? -15 : 0)
                            .scaleEffect(inner ? 0.8 : 1)
                            .foregroundColor(isTapped ? config.placeHolderHighlightedColor : config.placeHolderColor)
                    }
                
                if !image.isEmpty {
                    Button {
                        
                    } label: {
                        Image(systemName: image)
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(isTapped ? .accentColor : .gray)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(config.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(attemp > 0 ? config.errorColor : .clear, lineWidth: 1)
                )
        )
        .padding(.horizontal, 16)
        .modifier(Shake(animatableData: attemp))
    }
}

extension FloatingPlaceHolderTextField {
    struct Config {
        var backgroundColor: Color = .cyan.opacity(0.09)
        var placeHolderColor: Color = .gray
        var placeHolderHighlightedColor: Color = .accentColor
        var errorColor: Color = .red
    }
}

struct FloatingPlaceHolderTextField_Previews: PreviewProvider {
    @State static private var boom = ""
    static var previews: some View {
        FloatingPlaceHolderTextField(text: $boom, placeHolder: "CustomTextField", image: "gear")
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        print(animatableData)
        return ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}
