//
//  CardView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 24/10/24.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityVoiceOverEnabled) var isVoiceOverEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor
    let card: Card
    var removal: (() -> Void)? = nil
    var moveCardToBottom: (() -> Void)? = nil
    @State private var shouldDismiss: Bool = false
    @State private var offset = CGSize.zero
    @State private var isShowingAnswer = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(
                    diffWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    diffWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25)
                            .fill(offset.width > 50 ? .green : offset.width < -50 ? .red : .white)
                )
                .shadow(radius: 10)
            
            VStack {
                if isVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(shouldDismiss ? .degrees(offset.width / 5.0) : .zero)
        .offset( x: shouldDismiss ? offset.width * 5 : 0)
        .opacity( shouldDismiss ? 2 - Double(abs(offset.width / 50)) : 1)
        .accessibilityAddTraits(.isButton)
        .gesture(DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                if gesture.translation.width > -50 {
                    shouldDismiss = true
                } else {
                    shouldDismiss = false
                }
            }
            .onEnded { _ in
                if offset.width < -100 {
                    // Move card to the bottom if swiped left
                    
                    moveCardToBottom?()
                } else if offset.width > 100 {
                    // Remove card if swiped right
                    removal?()
                } else {
                    offset = .zero
                }
            }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
    }
}

#Preview {
    CardView(card: .example)
}
