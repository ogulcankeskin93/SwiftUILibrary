//
//  FloatingPlaceHolderTextField.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 23.01.2022.
//

import SwiftUI

struct FloatingTextField: View {
    @Binding var text: String
    @Binding var validation: ValidationState?
    let placeHolder: String
    let image: String
    @ObservedObject private var config = FloatingLabelTextFieldConfig()
    
    @State private var isTapped = false
    // For error handling
    @State private var attemp = CGFloat(0)
    
    @State private var isSecured = true
    @Namespace var namespace
    private let floatAnimationId = "floatMatchedGeo"
    
    private var floatPlaceholder: Bool {
        if isTapped || !text.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    init(text: Binding<String>, validation: Binding<ValidationState?>, placeHolder: String, image: String = "") {
        self._text = text
        self._validation = validation
        self.placeHolder = placeHolder
        self.image = image
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            _TextField
                .background(alignment: .leading) {
                    if !floatPlaceholder {
                        Text(placeHolder)
                            .fontWeight(Font.Weight.bold)
                            .matchedGeometryEffect(id: floatAnimationId, in: namespace)
                            .foregroundColor(isTapped ? config.placeHolderHighlightedColor : config.placeHolderColor)
                    }
                }
            
            if config.isSecuredActive {
                Button {
                    isSecured.toggle()
                } label: {
                    Image(systemName: isSecured ? "eye.fill" : "eye.slash.fill")
                }
                .buttonStyle(.plain)
                .foregroundColor(isTapped ? .accentColor : .gray)
            } else if !image.isEmpty {
                Button {
                    // TODO: on image click
                } label: {
                    Image(systemName: image)
                }
                .buttonStyle(.plain)
                .foregroundColor(isTapped ? .accentColor : .gray)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(config.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(validation?.isInvalid == true ? config.errorBorderColor : .clear, lineWidth: 1)
                )
        )
        .overlay(alignment: .topLeading) {
            if case .invalid(_) = validation {
                if let errorMessage = validation?.errorMessage {
                    Text(errorMessage)
                        .fontWeight(Font.Weight.bold)
                        .background(
                            Color(uiColor: .systemBackground)
                                .opacity(0.8)
                                .cornerRadius(8)
                                .offset(y: -8)
                                .shadow(color: Color(uiColor: .systemBackground).opacity(0.8), radius: 10, x: 0.0, y: 1)
                        )
                        .foregroundColor(config.errorColor)
                        .padding(.horizontal, 16)
                        .offset(y: -12)
                }
                
            } else if floatPlaceholder {
                Text(placeHolder)
                    .fontWeight(Font.Weight.bold)
                    .matchedGeometryEffect(id: floatAnimationId, in: namespace)
                    .background(
                        Color(uiColor: .systemBackground)
                            .opacity(0.8)
                            .offset(y: -8)
                            .shadow(color: Color(uiColor: .systemBackground).opacity(0.3), radius: 5, x: 0.0, y: 10)
                    )
                    .foregroundColor(isTapped ? config.placeHolderHighlightedColor : config.placeHolderColor)
                    .padding(.horizontal, 16)
                    .offset(y: -12)
            }
        }
        .padding(.horizontal, 16)
        .modifier(Shake(animatableData: attemp))
        .onChange(of: validation) { newValue in
            if case .invalid(_) = newValue {
                withAnimation {
                    self.attemp += 1
                }
            }
        }
    }
    
    var _TextField: some View {
        if config.isSecuredActive && isSecured {
            return SecureField(
                "",
                text: $text,
                onCommit: {
                    withAnimation(.easeOut) {
                        if text.isEmpty {
                            isTapped = false
                        }
                    }
                })
                .eraseToAnyView()
        }
        return TextField(
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
                withAnimation(.easeOut) {
                    if text.isEmpty {
                        isTapped = false
                    }
                }
            }
        )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .eraseToAnyView()
    }
}

struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        ClosarEditProfile()
            .preferredColorScheme(.light)
            .previewDisplayName("iPhone 12")
        
        
        ClosarEditProfile()
            .preferredColorScheme(.dark)
            .previewDisplayName("iPhone 11")
        
    }
}

extension FloatingTextField {
    class FloatingLabelTextFieldConfig: ObservableObject {
        @Published var backgroundColor: Color = .cyan.opacity(0.4)
        @Published var placeHolderColor: Color = .yellow
        @Published var placeHolderHighlightedColor: Color = .yellow
        @Published var errorColor: Color = .red.opacity(0.9)
        @Published var errorBorderColor: Color = .red.opacity(0.7)
        @Published var isSecuredActive: Bool = false
    }
    
    public func placeHolderColor(_ color: Color) -> Self {
        config.placeHolderColor = color
        return self
    }
    
    public func backgroundColor(_ color: Color) -> Self {
        config.backgroundColor = color
        return self
    }
    
    public func placeHolderHighlightedColor(_ color: Color) -> Self {
        config.placeHolderHighlightedColor = color
        return self
    }
    
    public func errorColor(_ color: Color) -> Self {
        config.errorColor = color
        return self
    }
    
    public func secured(_ active: Bool) -> Self {
        config.isSecuredActive = active
        return self
    }
}
