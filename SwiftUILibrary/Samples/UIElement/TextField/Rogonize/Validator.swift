//
//  Validator.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 25.01.2022.
//

import Foundation

typealias Validator = (String) throws -> Void

enum ValidationError: Error {
    case invalid(String)
}

enum Validation {
    public static func isEmailValid(_ string: String) throws -> Void {
        if string.count > 265 {
            throw ValidationError.invalid("Email is longer than 265")
        }
        // swiftlint:disable all
        let emailFormat =
        "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        if !emailPredicate.evaluate(with: string) {
            throw ValidationError.invalid("Not e-mail, try again")
        }
    }
    
    public static func isEmailValidNonThrow(_ string: String) -> Bool {
        if string.count > 265 {
            return false
        }
        // swiftlint:disable all
        let emailFormat =
        "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    
    public static func isPasswordValid(_ string: String) -> Bool {
        if string.count > 265 {
            return false
        }
        
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!~<>'`,;:_=?*+#.\"&%(){}\\|\\[\\]\\-\\$\\^\\@\\/\\\\])(?=.{8,})"
        return string.matches(pattern)
    }
    
    public static func passwordMatches8Chars(_ string: String) throws -> Void {
        let pattern = "^(?=.{8,})"
        if !string.matches(pattern) {
            throw ValidationError.invalid("Password must be 8 char.")
        }
    }
    
    public static func isNotEmpty(_ string: String) -> Bool {
        !string.isEmpty
    }
}


public extension String {
    
    /// Helper to easily check if a string matches a regular Expression
    /// - Parameter regex: The regularExpression you would like to test on the string
    /// - Returns: True if the regex matches, false if not
    func matches(_ regex: String) -> Bool {
        self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
