//
//  FloatingPlaceHolderTextField.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 23.01.2022.
//

import SwiftUI

struct BetterTextField: View {
    @Binding var text: String
    @Binding var validation: ValidationState?
    let placeHolder: String
    let image: String
    let config: Config
    
    @State private var isTapped = false
    // For error handling
    @State private var attemp = CGFloat(0)
    
    @Namespace var namespace
    
    var innerCheck: Bool {
        if isTapped {
            return true
        } else {
            if !text.isEmpty {
                return true
            }
        }
        return false
    }
    
    init(text: Binding<String>, validation: Binding<ValidationState?>, placeHolder: String, image: String = "", config: Config = .init()) {
        self._text = text
        self.placeHolder = placeHolder
        self.image = image
        self.config = config
        self._validation = validation
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
                            }
                        }
                    }
                )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .background(alignment: .leading) {
                        if !innerCheck {
                            Text("Boom")
                                .matchedGeometryEffect(id: "rectangleUnique", in: namespace)
                                .foregroundColor(isTapped ? config.placeHolderHighlightedColor : config.placeHolderColor)
                        }
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
                        .stroke(validation?.isInvalid == true ? config.errorColor : .clear, lineWidth: 1)
                )
        )
        .overlay(alignment: .topLeading) {
            if validation?.isInvalid == true {
                Text("todo desc")
                    .background(Color.white.opacity(0.89))
                    .shadow(color: .white.opacity(0.3), radius: 10, x: 0.0, y: 10)
                    .foregroundColor(.red)
                    .padding(.horizontal, 16)
                    .offset(y: -12)
                
            } else if innerCheck {
                Text("Boom")
                    .background(Color.white.opacity(0.3))
                    .matchedGeometryEffect(id: "rectangleUnique", in: namespace)
                    .foregroundColor(isTapped ? config.placeHolderHighlightedColor : config.placeHolderColor)
                    .padding(.horizontal, 16)
                    .offset(y: -8)
            }
        }
        .padding(.horizontal, 16)
        .modifier(Shake(animatableData: attemp))
        .onChange(of: validation) { newValue in
            if newValue != .valid {
                withAnimation {
                    self.attemp += 1
                }
            }
        }
    }
}

extension BetterTextField {
    struct Config {
        var backgroundColor: Color = .cyan.opacity(0.09)
        var placeHolderColor: Color = .gray
        var placeHolderHighlightedColor: Color = .accentColor
        var errorColor: Color = .red
    }
}
