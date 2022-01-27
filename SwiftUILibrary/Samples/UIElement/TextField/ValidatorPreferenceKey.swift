//
//  ValidatorPreferenceKey.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 26.01.2022.
//

import SwiftUI

struct ValidatorPreferenceKey: PreferenceKey {
    typealias Value = [ValidatorKey]
    
    static var defaultValue: Value = []
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value.append(contentsOf: nextValue())
    }
}

extension View {
    func validators(_ validator: [ValidatorKey]) -> some View {
        self.preference(key: ValidatorPreferenceKey.self, value: validator)
    }
}
