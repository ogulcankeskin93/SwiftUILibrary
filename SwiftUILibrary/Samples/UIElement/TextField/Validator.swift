//
//  Validator.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 25.01.2022.
//

import Foundation

enum ValidatorKey {
    case email
    case nonEmpty
    case profanity
}

extension ValidatorKey {
    func validate(_ text: String) -> String {
        switch self {
        case .email:
            return EmailValidator().validate(text)
        case .profanity:
            return ProfanityValidator().validate(text)
        default:
            return ""
        }
    }
}

protocol Validator {
    func validate(_ text: String) -> String
}

struct EmailValidator: Validator {
    func validate(_ text: String) -> String {
        guard !text.isEmpty else { return "" }
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
//                valid = false
                return "Invalid"
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
//            valid = false
            return "Error"
        }
        
        return ""
    }
}

struct ProfanityValidator: Validator {    
    func validate(_ text: String) -> String {
        if text.contains("fuck") {
            return "No no no no"
        } else {
            return ""
        }
    }
}
