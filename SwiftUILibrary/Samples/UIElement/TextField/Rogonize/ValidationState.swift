//
//  ValidationState.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 1.02.2022.
//

import Foundation

public enum ValidationState: Hashable, Equatable {
    case valid
    case invalid(String?)
    
    public var isValid: Bool {
        return self == .valid
    }

    public var errorMessage: String? {
        if case .invalid(let errorMessage) = self {
            return errorMessage
        } else {
            return nil
        }
    }
}
