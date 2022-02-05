//
//  ValidatorPrepView.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 26.01.2022.
//

import Foundation
import SwiftUI

struct ValidatorPrepView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            FloatingTextField(
                text: $viewModel.inputText,
                validation: $viewModel.inputTextValid,
                placeHolder: "Email"
            )
            
            Button {
                
            } label: {
                Text("Boom")
            }
            .disabled(viewModel.inputTextValid != .valid)
        }
        
    }
}

import Combine
extension ValidatorPrepView {
    class ViewModel: ObservableObject {
        private var cancellables = Set<AnyCancellable>()
        
        @Published var inputText = "blop"
        @Published var inputTextValid: ValidationState?
        
        
        //        @Published var inputSecondText = "blop"
        //        @Published var inputSecondTextValid: ValidationState?
        
        init() {
            setupValidation()
        }
        
        private func setupValidation() {
            $inputText
                .validate(validateEmpty: false, via: [Validation.isEmailValid(_:), Validation.passwordMatches8Chars(_:)])
                .assign(to: \.inputTextValid, on: self)
                .store(in: &cancellables)
        }
    }
}

struct ValidatorPrepView_Previews: PreviewProvider {
    static var previews: some View {
        ValidatorPrepView()
    }
}
