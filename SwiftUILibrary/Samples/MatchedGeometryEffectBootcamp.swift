//
//  MatchedGeometryEffectBootcamp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 31.12.2021.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    @State private var moveRectangle = false
    @Namespace var namespace
    
    var body: some View {
        VStack {
            SliderMenuWidthIndicator()
                .padding(.bottom)
            
            if !moveRectangle {
                RoundedRectangle(cornerRadius: 8)
                    .matchedGeometryEffect(id: "rectangleUnique", in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            if moveRectangle {
                RoundedRectangle(cornerRadius: 8)
                // MARK: matchedGeometryEffect before frame
                    .matchedGeometryEffect(id: "rectangleUnique", in: namespace)
                    .frame(width: 100, height: 100)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .onTapGesture {
            withAnimation {
                moveRectangle.toggle()
            }
        }
    }
}

struct SliderMenuWidthIndicator: View {
    private let menuTitles = ["Hello", "Salut", "Hallo"]
    @State private var selected = ""
    @Namespace var namespace

    var body: some View {
        HStack {
            ForEach(menuTitles, id: \.self) { each in
                ZStack(alignment: .bottom) {
                    if selected == each {
                        Rectangle()
                            .fill(Color.pink)
                            .matchedGeometryEffect(id: "indicator", in: namespace)
                            .frame(width: 50, height: 3)
                            .offset(y: 10)
                    }
                    
                    Text(each)
                        .font(.system(size: 30))
                        .onTapGesture {
                            withAnimation {
                                selected = each
                            }
                        }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
            }
        }
    }
}

struct MatchedGeometryEffectBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectBootcamp()
    }
}
