//
//  FloatingPlaceHolderTextField.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 23.01.2022.
//

import SwiftUI

class ValidatorManager: ObservableObject {
    @Published var errorDesc = ""
    @Published var validators: [ValidatorKey] = []
    @Published var attemp = CGFloat(0)
    @Published var onError: Bool?
    
    init(validators keys: [ValidatorKey]) {
        self.validators = keys
    }
    
    func validate(_ text: String) {
        var error = ""
        for each in validators {
            let str = each.validate(text)
            if !str.isEmpty {
                error = str
                break
            }
        }
        
        if error.isEmpty {
            errorDesc = ""
            attemp = 0
        } else {
            errorDesc = error
            attemp += 1
        }
        
        onError = attemp > 0
    }
}

struct FloatingPlaceHolderTextField: View {
    @Binding var text: String
    let placeHolder: String
    let image: String
    let config: Config
    
    @State private var isTapped = false

    @Namespace var namespace

    @EnvironmentObject var validatorManager: ValidatorManager
    
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
                            }
                            validatorManager.validate(text)
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
                        .stroke(validatorManager.onError == true ? config.errorColor : .clear, lineWidth: 1)
                )
        )
        .overlay(alignment: .topLeading) {
            if validatorManager.onError == true {
                Text(validatorManager.errorDesc)
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
        .modifier(Shake(animatableData: validatorManager.attemp))
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
    struct PrivewViewSut: View {
        @State var boom = ""
        var body: some View {
            FloatingPlaceHolderTextField(text: $boom, placeHolder: "CustomTextField", image: "gear")
        }
    }
    static var previews: some View {
        PrivewViewSut()
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
//        print(animatableData)
        return ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}
