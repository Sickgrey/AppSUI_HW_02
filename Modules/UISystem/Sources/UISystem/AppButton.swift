//
//  AppButton.swift
//  
//
//  Created by Сергей Смирнов on 30/7/23.
//

import SwiftUI

struct AppButton<Content>: View where Content: View {
    private let color: Color
    private let action: () -> Void
    private let content: () -> Content
    
    @State var bgOpacity: Double = 1
    
    public init(color: Color, action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.color = color
        self.action = action
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(color)
                .opacity(bgOpacity)
            HStack {
                content()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
        }
        .fixedSize(horizontal: true, vertical: true)
        .gesture(
            DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
                .onChanged { _ in
                    withAnimation {
                        bgOpacity = 0.5
                    }
                }
                .onEnded { _ in
                    bgOpacity = 1
                    action()
                }
        )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AppButton(color: .green) {} content: {
                Text("Green").foregroundColor(.white)
            }
        }
    }
}
