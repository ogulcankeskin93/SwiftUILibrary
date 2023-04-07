//
//  SwiftUILibraryApp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 31.12.2021.
//

import SwiftUI

@main
struct SwiftUILibraryApp: App {
    @StateObject private var viewModel = LocationViewModel()

    var body: some Scene {
        WindowGroup {
//            ClosarEditProfile()
            LocationView()
                .environmentObject(viewModel)
        }
    }
}
