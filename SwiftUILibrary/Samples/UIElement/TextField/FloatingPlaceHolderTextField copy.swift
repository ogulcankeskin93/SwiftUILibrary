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
    
    @State private var isTapped = false
    @State private var attemp = CGFloat(0)
    @State private var errorDesc = ""
    
    @ObservedObject private var config = FloatingLabelTextFieldConfig()

    @Namespace var namespace

    private var validators: [Validator] = [EmailValidator(), ProfanityValidator()]
    
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
    }
    
    func validate() {
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
                               validate()
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
                        .stroke(attemp > 0 ? config.errorColor : .clear, lineWidth: 1)
                )
        )
        .overlay(alignment: .topLeading) {
            if attemp > 0 {
                Text(errorDesc)
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
        print(animatableData)
        return ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}

@available(iOS 13.0, *)
class FloatingLabelTextFieldConfig: ObservableObject {
    @Published var backgroundColor: Color = .cyan.opacity(0.09)
    @Published var placeHolderColor: Color = .gray
    @Published var placeHolderHighlightedColor: Color = .accentColor
    @Published var errorColor: Color = .red
}
