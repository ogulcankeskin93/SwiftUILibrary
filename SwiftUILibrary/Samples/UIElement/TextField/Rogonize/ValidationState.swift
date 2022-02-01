//
//  ValidationState.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 1.02.2022.
//

import Combine
import Foundation

public enum ValidationState: Hashable, Equatable {
    case valid
    case invalid(String?)
    
    public var isValid: Bool {
        return self == .valid
    }
    
    public var isInvalid: Bool {
        switch self {
        case .invalid:
            return true
        default:
            return false
        }
    }

    public var errorMessage: String? {
        if case .invalid(let errorMessage) = self {
            return errorMessage
        } else {
            return nil
        }
    }
}

extension Publisher where Output == String {
    /// Performs validation on a String input and only forwards the invalid state, not the valid state.
    /// Use to validate input fields you not want to explicity mark as valid (e.g. green).
    /// - Parameter validation: the validation function
    /// - Returns: Publisher
    func markInvalid(
        validateEmpty: Bool = false,
        via validation: @escaping (String) -> Bool,
        errorMessage: String? = nil
    ) -> AnyPublisher<ValidationState?, Failure> {
        map {
            // Only validate if the email field is not empty
            (!validateEmpty && $0.isEmpty) ? true : validation($0)
        }
        .map {
            // Only set a validation state for invalid states (because
            // valid state should look like normal state)
            $0 ? nil : .invalid(errorMessage)
        }
        .eraseToAnyPublisher()
    }
    
    func markInvalid(
        validateEmpty: Bool = false,
        via keys: [Validator],
        errorMessage: String? = nil
    ) -> AnyPublisher<ValidationState?, Failure> {
        map {
            // Only validate if the email field is not empty
            var valid = true
            for key in keys {
                let temp = (!validateEmpty && $0.isEmpty) ? true : key($0)
                if !temp {
                    valid = false
                    break
                }
            }
            return valid
        }
        .map {
            // Only set a validation state for invalid states (because
            // valid state should look like normal state)
            $0 ? nil : .invalid(errorMessage)
        }
        .eraseToAnyPublisher()
    }
}
