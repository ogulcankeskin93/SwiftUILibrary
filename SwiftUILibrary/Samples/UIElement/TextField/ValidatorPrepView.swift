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
            FloatingPlaceHolderTextField(text: $viewModel.emailInput, placeHolder: "CustomTextField", image: "gear")
                .environmentObject(viewModel.emailInputValidator)
            
            Button {
                
            } label: {
                Text("Boom")
            }
            .disabled(!(viewModel.emailInputValidator.onError == false && !viewModel.emailInput.isEmpty))
        }
            
    }
}

extension ValidatorPrepView {
    class ViewModel: ObservableObject {
        @Published var emailInput = ""
        @ObservedObject var emailInputValidator = ValidatorManager(validators: [.email, .nonEmpty])
    }
}

struct ValidatorPrepView_Previews: PreviewProvider {
    static var previews: some View {
        ValidatorPrepView()
    }
}
