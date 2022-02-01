//
//  Validator.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 25.01.2022.
//

import Foundation

typealias Validator = (String) -> Bool

var isPasswordValid: Validator = { string in
    if string.count > 265 {
        return false
    }
    
    let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!~<>'`,;:_=?*+#.\"&%(){}\\|\\[\\]\\-\\$\\^\\@\\/\\\\])(?=.{8,})"
    return string.matches(pattern)
}

var isNotEmpty: Validator = { string in
    !string.isEmpty
}

var greaterThan_3: Validator = { string in
    string.count > 3
}

public extension String {
    
    /// Helper to easily check if a string matches a regular Expression
    /// - Parameter regex: The regularExpression you would like to test on the string
    /// - Returns: True if the regex matches, false if not
    func matches(_ regex: String) -> Bool {
        self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
