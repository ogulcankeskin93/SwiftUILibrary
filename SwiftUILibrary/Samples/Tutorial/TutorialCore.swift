//
//  TutorialCore.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 5.01.2022.
//

import SwiftUI

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
