//
//  CustomMessage.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 11.12.23.
//

import SwiftUI

struct CustomMessage: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(UXComponents.self) private var uxComponents
    
    let isActive: Bool
    let type: MessageType
    let text: String
    
    @State private var offset: CGSize = .zero
    @State private var transitionSide: TransitionSide = .right
    
    var body: some View {
        if isActive {
            ZStack {
                HStack {
                    Image(systemName: type.getData().icon)
                        .foregroundStyle(type.getData().color)
                        .font(.title)
                        .padding(.leading, 10)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(type.getData().title)
                            .font(.title2)
                        
                        Text(text)
                            .foregroundStyle(.secondary)
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .background(colorScheme == .dark ? .customSecondary : .white)
                .padding(.leading, 7)
            }
            .background(type.getData().color)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: .black.opacity(0.1), radius: 7, x: 0, y: 0)
            .padding(.horizontal)
            .offset(x: offset.width / 2)
            .transition(transitionSide == .right ? .customSlideToRight : .customSlideToLeft)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { gesture in
                        let swipeWidth = gesture.translation.width
                        if abs(swipeWidth) > 130 {
                            if swipeWidth < 0 {
                                transitionSide = .left
                            } else {
                                transitionSide = .right
                            }
                            uxComponents.showMessage = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                offset = .zero
                                transitionSide = .right
                            }
                        } else {
                            withAnimation(.bouncy) {
                                offset = .zero
                            }
                        }
                    }
            )
        }
    }
}

#Preview {
    CustomMessage(isActive: true, type: .error, text: "Message text")
        .environment(UXComponents.shared)
    
}
