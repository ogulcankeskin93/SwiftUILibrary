//
//  SizePreferenceKey.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 3.01.2022.
//

import SwiftUI


public protocol SizePreferenceKey: LatestValuePreferenceKey {}

public extension SizePreferenceKey {
    static var defaultValue: CGSize {
        .zero
    }
}

public protocol LatestValuePreferenceKey: PreferenceKey {}

public extension LatestValuePreferenceKey {
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}


struct SizeReaderModifier<K: PreferenceKey>: ViewModifier where K.Value == CGSize {
    let key: K.Type
    let handler: (K.Value) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color
                        .clear
                        .preference(key: key, value: proxy.size)
                }
                    .onPreferenceChange(key, perform: handler)
            )
    }
}

extension View {
    func readSize<K: PreferenceKey>(_ key: K.Type, into binding: Binding<CGSize>) -> some View where K.Value == CGSize {
        modifier(
            SizeReaderModifier(
                key: key,
                handler: {
                    print($0)
                    binding.wrappedValue = $0
                }
            )
        )
    }
}
