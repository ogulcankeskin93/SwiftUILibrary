//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 2.01.2022.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(0..<50) { i in
                        Rectangle()
                            .fill(.pink.opacity(0.6))
                            .cornerRadius(8)
                            .frame(height: 200)
                            .padding()
                            .if(i == 0) { view in
                                view
                                    .modifier(SizePreferenceModifier())
                            }
                    }
                }
            }
//            .onPreferenceChange(<#T##key: PreferenceKey.Protocol##PreferenceKey.Protocol#>, perform: <#T##(Equatable) -> Void#>)
            .overlayPreferenceValue(SizeKey.self, { value in
                Text("\(value)")
            })
            .navigationTitle("Blop Blop Blop")
        }
    }
}

struct SizePreferenceModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geo in
                    Text("")
                        .preference(key: SizeKey.self, value: geo.frame(in: .global).minY)
                }
            }
    }
}

struct SizeKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct GeometryPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKey()
    }
}
