//
//  TutorialViewModel.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 5.01.2022.
//

import Foundation

public enum TutorialContentKey: String, CaseIterable {
   case name, password, login, signup
}

class TutorialViewModel: ObservableObject {
    var tutorials: [TutorialContentKey: TutorialContentItem] = [
        .name: .init(location: .top, text: "Name Tutorial Description"),
        .password: .init(location: .top, text: "Password Tutorial Description"),
        .login: .init(location: .bottom, text: "Login Tutorial Description"),
        .signup: .init(location: .bottom, text: "Signup Tutorial Description")
    ]
    
    @Published var activeTutorials: [TutorialContentKey] = []
    
    init() {
        activeTutorials.append(.name)
    }
    
    func nextTutorial() {
        let allCases = TutorialContentKey.allCases
        if allCases.count == activeTutorials.count {
            activeTutorials.removeAll()
            return
        }
        
        if activeTutorials.isEmpty {
            activeTutorials.append(.name)
        } else if let index =  allCases.firstIndex(of: activeTutorials.last!) {
            let temp = allCases[index + 1]
            activeTutorials.append(temp)
        }
    }
}
