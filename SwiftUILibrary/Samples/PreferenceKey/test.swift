////
////  TutorialView.swift
////  SwiftUILibrary
////
////  Created by Ogulcan Keskin on 2.01.2022.
////
//
//import SwiftUI
//
//struct AnchoredSizePreferenceKey<Item: Hashable>: PreferenceKey {
//    typealias Value = [Item: Anchor<CGRect>]
//
//    static var defaultValue: Value { [:] }
//
//    static func reduce(
//        value: inout Value,
//        nextValue: () -> Value
//    ) {
//        value.merge(nextValue()) { $1 }
//    }
//}
//
//struct TutorialView: View {
//    @State private var index = 0
//
//    @State var value: String = ""
//
//    var body: some View {
//
//        ZStack {
//            Color.blue.opacity(0.3)
//            VStack(spacing: 20) {
//                VStack {
//                    TextField("Name", text: .constant(""))
//                        .extensionTextFieldView(roundedCornes: 6, startColor: .white, endColor: .purple)
//                    TextField("Name", text: .constant(""))
//                        .extensionTextFieldView(roundedCornes: 6, startColor: .pink.opacity(0.5), endColor: .white.opacity(0.6))
//
//                }
//                .padding(.horizontal, 30)
//
//                HStack {
//                    Button {
//
//                    } label: {
//                        Text("Login")
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(height: 45)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .cornerRadius(8)
//                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
//                    }
//                    .anchorPreference(
//                        key: AnchoredSizePreferenceKey<String>.self,
//                        value: .bounds,
//                        transform: { anchor in
//                            ["login": anchor]
//                        })
//
//                    Button {
//
//                    } label: {
//                        Text("Sign Up")
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(height: 45)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .cornerRadius(8)
//                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
//                    }
//                    .anchorPreference(
//                        key: AnchoredSizePreferenceKey<String>.self,
//                        value: .bounds) { anchor in
//                            ["signup": anchor]
//                        }
//                }
//                .padding(.horizontal, 24)
//
//
//            }
//
//
//            Button {
//                index += 1
//                value = index % 2 == 0 ? "login" : "signup"
//            } label: {
//                Text("Tutorial")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(height: 45)
//                    .frame(maxWidth: .infinity, alignment: .bottom)
//                    .background(Color.cyan)
//                    .cornerRadius(8)
//                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//            .padding(.horizontal, 10)
//            .padding(.bottom, 50)
//
//
//        }
//        .ignoresSafeArea()
//        .if(index != 0, transform: { view in
//            view
//                .overlayPreferenceValue(
//                    AnchoredSizePreferenceKey<String>.self) { anchor in
//                        GeometryReader { geometry in
//                            if let value = anchor[self.value] {
//                                let temp = geometry[value]
//                                Rectangle()
//                                    .fill(.red)
//                                    .frame(
//                                        width: temp.width,
//                                        height: temp.height
//                                    )
//                                    .offset(
//                                        x: temp.minX,
//                                        y: temp.minY
//                                    )
//                            }
//                        }
//                    }
//        })
//
//
//    }
//}
//
//struct TutorialView_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialView()
//    }
//}
//
//
//
//extension TextField {
//    func extensionTextFieldView(roundedCornes: CGFloat, startColor: Color,  endColor: Color) -> some View {
//        self
//            .padding()
//            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
//            .cornerRadius(roundedCornes)
//            .shadow(color: .purple, radius: 10)
//    }
//}
