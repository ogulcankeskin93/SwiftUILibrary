//
//  AnchorPreferences.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 2.01.2022.
//

import SwiftUI

/**
 Anchor preferences use opaque Anchor type.
 You can’t merely use Anchor type anywhere in the app.
 You have to use it in pair with GeometryProxy provided by GeometryReader.
 You can use the subscript of GeometryProxy to resolve anchor and access wrapped CGRect value.
 As a bonus, SwiftUI will convert a coordinate space between views while solving anchor, and you don’t need to do it manually.
 */

struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    
    static var defaultValue: Value = nil
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}

struct AnchorPreference: View {
    var body: some View {
        ZStack {
            Color.yellow
            Text("Hello World !!!")
                .anchorPreference(
                    key: BoundsPreferenceKey.self,
                    value: .bounds
                ) { $0 }
            
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { preferences in
                GeometryReader { geometry in
                    preferences.map { val in
                        // val: Anchor<CGRect>
                        return Rectangle()
                            .stroke()
                            .frame(
                                width: geometry[val].width,
                                height: geometry[val].height
                            )
                            .offset(
                                x: geometry[val].minX,
                                y: geometry[val].minY
                            )
                    }
            }
            
        }
    }
}


struct AnchorPreference_Previews: PreviewProvider {
    static var previews: some View {
        AnchorPreference()
    }
}
