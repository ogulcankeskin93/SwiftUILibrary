//
//  ContentView.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 23.12.2021.
//

import SwiftUI

struct MaskViewBootcamp: View {
    // MARK:
    @State var rating = 2
    
    var body: some View {
        starsView
            .overlay(
                overlayView.mask(starsView)
            )
    }
    
    private var overlayView: some View {
        GeometryReader { geo in
            Rectangle()
                .foregroundColor(.yellow)
                .frame(width: geo.size.width * CGFloat(rating) / 5, alignment: .leading)
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}

struct MaskViewBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskViewBootcamp()
    }
}
