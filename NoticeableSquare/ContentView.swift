//
//  ContentView.swift
//  NoticeableSquare
//
//  Created by Романенко Иван on 12.03.2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var position = CGPoint.zero
    
    private let colors = [Color.white, .pink, .yellow, .black]
    private let rectSize: CGFloat = 100
    
    private var gesture: some Gesture {
        DragGesture()
            .onChanged { value in
                position = value.location
            }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: .zero) {
                ForEach(colors, id: \.self) { color in
                    color
                }
            }
            
            Rectangle()
                .frame(width: rectSize, height: rectSize)
                .foregroundColor(.white)
                .blendMode(.difference)
                .overlay(.blendMode(.hue))
                .overlay(Color.white.blendMode(.overlay))
                .overlay(Color.black.blendMode(.overlay))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .position(position)
                .gesture(gesture)
                .onAppear {
                    position = CGPoint(
                        x: proxy.frame(in: .global).midX,
                        y: proxy.frame(in: .global).midY-(rectSize/2)
                    )
                }
        }
        .compositingGroup()
    }
}

#Preview {
    ContentView()
}
