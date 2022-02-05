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
    func validateCustom(
        validateEmpty: Bool = false,
        via validation: @escaping (String) -> Bool,
        errorMessage: String? = nil
    ) -> AnyPublisher<ValidationState?, Failure> {
        map {
            // Only validate if the email field is not empty
            return (!validateEmpty && $0.isEmpty) ? true : validation($0)
        }
        .map {
            // Only set a validation state for invalid states (because
            // valid state should look like normal state)
            $0 ? nil : .invalid(errorMessage)
        }
        .eraseToAnyPublisher()
    }
    
    
    func validate(
        validateEmpty: Bool = false,
        via validators: [Validator],
        errorMessage: String? = nil
    ) -> AnyPublisher<ValidationState?, Failure> {
        map { string -> ValidationState? in
            if (!validateEmpty && string.isEmpty) {
                return nil
            } else {
                for validator in validators {
                    do {
                        try validator(string)
                    } catch let error {
                        guard let err = error as? ValidationError, case let .invalid(message) = err else { return nil }
                        return .invalid(message)
                    }
                }
            }
            return nil
        }
        .eraseToAnyPublisher()
    }
}
