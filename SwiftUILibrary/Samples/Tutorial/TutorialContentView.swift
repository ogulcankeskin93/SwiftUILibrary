//
//  TutorialContentView.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 3.01.2022.
//

import SwiftUI

fileprivate struct OverallSizeKey: SizePreferenceKey {}

struct TutorialContent {
    var bounds: Anchor<CGRect>
    var item: TutorialContentItem?
    var isHidden: Bool
}

public struct TutorialContentItem {
    var location: TutorialContentRelativeLocation
    var text: String
    public enum TutorialContentRelativeLocation {
        case left, top, right, bottom, topLeft, topRight, bottomLeft, bottomRight
    }
}

struct TutorialPreferenceKey: PreferenceKey {
    typealias Value = [TutorialContent]
    
    static var defaultValue: Value { [] }
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value.append(contentsOf: nextValue())
    }
}

public struct TutorialContentAnchoringViewModifier: ViewModifier {
    let item: TutorialContentItem?
    let isHidden: Bool
    
    public func body(content: Content) -> some View {
        content
            .anchorPreference(
                key: TutorialPreferenceKey.self,
                value: .bounds
            ) {
                [TutorialContent(bounds: $0, item: item, isHidden: isHidden)]
            }
    }
}

public struct TutorialContentView<Content: View>: View {
    @State private var overallSize: CGSize = .zero
    private let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .overlayPreferenceValue(TutorialPreferenceKey.self) { preferences in
                GeometryReader { geometry in
                    ZStack {
                        Color.gray.opacity(0.6)
                            .ignoresSafeArea()
                        
                        ForEach(0..<preferences.count) { index in
                            let tutorialContent = preferences[index]
                            if !tutorialContent.isHidden,
                               let bound = geometry[tutorialContent.bounds],
                               let item = tutorialContent.item {
                                switch item.location {
                                case .top:
                                    topContent(
                                        text: item.text,
                                        position: .init(
                                            x: bound.midX,
                                            y: bound.minY - Constants.spacingAtom - overallSize.height / 2
                                        ),
                                        rotation: 90)
                                case .bottom:
                                    bottomContent(
                                        text: item.text,
                                        position: .init(
                                            x: bound.midX,
                                            y: bound.maxY + Constants.spacingAtom + overallSize.height / 2
                                        ),
                                        rotation: -90)
                                default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
            }
            .onChange(of: overallSize) { newValue in
                print(newValue)
            }
    }
    
    @ViewBuilder
    private func topContent(
        text: String,
        position: CGPoint,
        rotation: Double,
        horizontalPadding: CGFloat = Constants.spacingAtom,
        alignment: HorizontalAlignment = .center
    ) -> some View {
        VStack(alignment: alignment, spacing: 0) {
            Spacer()
            tutorialText(text: text, horizontalPadding: horizontalPadding)
            tutorialArrowImage(rotation: rotation)
            Text("\(overallSize.height) \(overallSize.width)")
        }
        .readSize(OverallSizeKey.self, into: $overallSize)
        .position(
            x: position.x,
            y: position.y
        )
    }
    
    @ViewBuilder
    private func bottomContent(
        text: String,
        position: CGPoint,
        rotation: Double,
        horizontalPadding: CGFloat = Constants.spacingAtom,
        alignment: HorizontalAlignment = .center
    ) -> some View {
        VStack(alignment: alignment, spacing: 0) {
            tutorialArrowImage(rotation: rotation)
            tutorialText(text: text, horizontalPadding: horizontalPadding)
            Spacer()
        }
        .readSize(OverallSizeKey.self, into: $overallSize)
        .position(
            x: position.x,
            y: position.y
        )
    }
    
    @ViewBuilder
    private func tutorialText(text: String, horizontalPadding: CGFloat = Constants.spacingAtom) -> some View {
        Text(text)
            .font(.system(size: 20))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .padding(.horizontal, horizontalPadding)
    }
    
    @ViewBuilder
    private func tutorialArrowImage(rotation: Double) -> some View {
        Image(uiImage: .init(named: "arrowRight")!)
            .renderingMode(.template)
            .foregroundColor(.yellow)
            .frame(width: 24, height: 24)
            .rotationEffect(.degrees(rotation))
    }
}

public struct ConcreteTutorialView: View {
    public var body: some View {
        ZStack {
            Color.blue.opacity(0.3)
            
            VStack(spacing: 20) {
                VStack {
                    TextField("Name", text: .constant(""))
                        .extensionTextFieldView(roundedCornes: 6, startColor: .white, endColor: .purple)
                        .placeTutorialContent(
                            item: .init(location: .top, text: "This is Name Textfield"),
                            isHidden: false
                        )
                    
                    TextField("Password", text: .constant(""))
                        .extensionTextFieldView(roundedCornes: 6, startColor: .pink.opacity(0.5), endColor: .white.opacity(0.6))
                        .placeTutorialContent(
                            item: .init(location: .bottom, text: "This is Password Textfield"),
                            isHidden: false
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
                        item: .init(location: .right, text: "This is Login Button"),
                        isHidden: false
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
                        item: .init(location: .left, text: "This is Register Button"),
                        isHidden: false
                    )
                }
                .padding(.horizontal, 24)
            }
            
            Button {
                
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

struct TutorialContentView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialContentView {
            ConcreteTutorialView()
        }
    }
}

public extension View {
    func placeTutorialContent(
        item: TutorialContentItem?,
        isHidden: Bool
    ) -> some View {
        modifier(
            TutorialContentAnchoringViewModifier(item: item, isHidden: isHidden)
        )
    }
}

public enum Constants {
    public static let spacingAtom: CGFloat = 8
}
