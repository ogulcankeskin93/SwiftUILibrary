//
//  BackgroundBootcamp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 23.12.2021.
//

import SwiftUI

struct BackgroundBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(
                Circle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            )
            .background(
                Circle()
                    .fill(.blue)
                    .frame(width: 120, height: 120)
            )
        
    }
}

struct BackgroundBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundBootcamp()
    }
}
