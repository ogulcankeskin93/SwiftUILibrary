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
            BetterTextField(text: $viewModel.inputText, validation: $viewModel.inputTextValid, placeHolder: "boom")

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
        
        init() {
            setupValidation()
        }
        
        private func setupValidation() {
            $inputText
                .map { $0.count > 3 ? ValidationState.valid : .invalid("Must be at least 4 characters") }
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
