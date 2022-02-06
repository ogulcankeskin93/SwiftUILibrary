//
//  ClosarEditProfile.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 6.02.2022.
//

import SwiftUI

struct ClosarEditProfile: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(30)
                .background(.yellow.opacity(0.8))
                .clipShape(Circle())
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
            
            VStack(spacing: 30) {
                FloatingTextField(
                    text: $viewModel.email,
                    validation: $viewModel.emailValid,
                    placeHolder: "E-mail"
                )
                
                FloatingTextField(
                    text: $viewModel.password,
                    validation: $viewModel.passwordValid,
                    placeHolder: "Password"
                )
                
                FloatingTextField(
                    text: $viewModel.third,
                    validation: $viewModel.thirdValid,
                    placeHolder: "Password"
                )
                    .secured(true)
            }
            .padding(.vertical, 50)
            
            
            Button {
                
            } label: {
                Text("Save")
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(viewModel.saveEnabled ? Color.blue : Color.gray)
                    .cornerRadius(8)
            }
            .buttonStyle(FrenchBoutonStyle())
            .padding(.horizontal)
            .disabled(!viewModel.saveEnabled)


            
            Spacer()
        }
        .padding(.top)
        .frame(maxWidth: .infinity)
        .navigationTitle("Edit Profile")
    }
}

struct ClosarEditProfile_Previews: PreviewProvider {
    static var previews: some View {
//        ClosarEditProfile()
//            .preferredColorScheme(.light)
//            .previewDisplayName("iPhone 12")

        
        ClosarEditProfile()
            .preferredColorScheme(.dark)
            .previewDisplayName("iPhone 11")

        
    }
}

import Combine
extension ClosarEditProfile {
    class ViewModel: ObservableObject {
        private var cancellables = Set<AnyCancellable>()
        
        @Published var email = "ogul.kesk@gmail.com"
        @Published var emailValid: ValidationState?
        
        @Published var password = ""
        @Published var passwordValid: ValidationState?
        
        @Published var third = ""
        @Published var thirdValid: ValidationState?
        
        @Published var saveEnabled = false
        
        init() {
            setupValidation()
        }
        
        private func setupValidation() {
            $email
                .validate(validateEmpty: true, via: [
                    Validation.isNotEmpty(_:),
                    Validation.isEmailValid(_:),
                    Validation.passwordMatches8Chars(_:)
                ])
                .assign(to: \.emailValid, on: self)
                .store(in: &cancellables)
            
            $password
                .validate(validateEmpty: false, via: [
                    Validation.isNotEmpty(_:)
                ])
                .assign(to: \.passwordValid, on: self)
                .store(in: &cancellables)
            
            $third
                .validate(validateEmpty: true, via: [
                    Validation.passwordMatches8Chars(_:)
                ])
                .assign(to: \.thirdValid, on: self)
                .store(in: &cancellables)
            
        
            Publishers
                .CombineLatest3($emailValid, $passwordValid, $thirdValid)
                .map { [$0.0 == nil, $0.1 == nil, $0.2 == nil] }
                .map { $0.allSatisfy { $0 }}
                .assign(to: \.saveEnabled, on: self)
                .store(in: &cancellables)
        }
    }
}
