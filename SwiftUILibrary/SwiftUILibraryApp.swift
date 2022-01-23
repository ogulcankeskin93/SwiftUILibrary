//
//  SwiftUILibraryApp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 31.12.2021.
//

import SwiftUI

@main
struct SwiftUILibraryApp: App {
    @State var xoxo = "blop"
    var body: some Scene {
        WindowGroup {
            FloatingPlaceHolderTextField(text: $xoxo, placeHolder: "CustomTextField", image: "gear")
        }
    }
}
