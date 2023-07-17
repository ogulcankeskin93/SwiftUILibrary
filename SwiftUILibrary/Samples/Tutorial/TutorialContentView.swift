//
//  TutorialContentView.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 3.01.2022.
//

import SwiftUI

fileprivate struct OverallSizeKey: SizePreferenceKey {}

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
                        ForEach(0..<preferences.count) { index in
                            let tutorialContent = preferences[index]
                            if !tutorialContent.isHidden, let item = tutorialContent.item {
                               let bound = geometry[tutorialContent.bounds]
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

struct TutorialContentView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialContentView {
            TutorialView()
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
