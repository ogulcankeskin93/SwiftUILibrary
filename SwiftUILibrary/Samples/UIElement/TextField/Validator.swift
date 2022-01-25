//
//  Validator.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 25.01.2022.
//

import Foundation

protocol Validator {
    var isValid: Bool { get }
    func validate(_ text: String) -> String
}

class EmailValidator: Validator {
    var isValid: Bool = false
    
    func validate(_ text: String) -> String {
        var valid = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                valid = false
                return "Invalid"
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            valid = false
            return "Error"
        }
        
        isValid = valid
        return ""
    }
}

class ProfanityValidator: Validator {
    var isValid: Bool = false
    
    func validate(_ text: String) -> String {
        isValid = !text.contains("fuck")
        if isValid {
            return ""
        } else {
            return "No no no no"
        }
    }
}
