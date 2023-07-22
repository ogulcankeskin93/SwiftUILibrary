//
//  Profile.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 22.07.2023.
//

import Foundation

struct Profile: Identifiable {
    let id = UUID().uuidString
    let userName, picture, lastMsg, lastActive: String
}

extension Profile {
    static var mocks: [Profile] =
        [
            Profile(userName: "Eiffel", picture: "paris-eiffeltower-1", lastMsg: "Hi from Paris", lastActive: "10:25 PM"),
            Profile(userName: "Louvre", picture: "paris-louvre-1", lastMsg: "Hi from Louvre", lastActive: "06:25 AM"),
            Profile(userName: "Colosseum", picture: "rome-colosseum-1", lastMsg: "Hi from Colosseum", lastActive: "01:30 PM"),
            Profile(userName: "Pantheon", picture: "rome-pantheon-2", lastMsg: "Hi from Pantheon", lastActive: "03:03 AM"),
            Profile(userName: "Trevifountain", picture: "rome-trevifountain-1", lastMsg: "Hi from Trevifountain", lastActive: "15:33 PM")
        ]
}
