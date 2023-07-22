//
//  AnchorHelper.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 22.07.2023.
//

import SwiftUI

struct MNAnchorKey: PreferenceKey {

    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) {
            $1
        }
    }
    
}
