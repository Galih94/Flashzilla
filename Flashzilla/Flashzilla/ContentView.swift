//
//  ContentView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var isVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var showingEditScreen = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let storageManager: iStorageManager = StorageManager()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(cards) { card in
                        if let index = cards.firstIndex(where: { $0.id == card.id }) {
                            CardView(card: card, removal: {
                                withAnimation {
                                    removeCard(at: index)
                                }
                            }, moveCardToBottom: {
                                withAnimation {
                                    moveCardToBottom(index: index)
                                }
                            })
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                        }
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if cards.isEmpty {
                    Button("Start Again") {
                        resetCards()
                    }
                    .padding()
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(.capsule)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }

                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if diffWithoutColor || isVoiceOverEnabled{
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            /// do something on tapped x
                            withAnimation {
                                moveCardToBottom(index: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        Spacer()
                        
                        Button {
                            /// do something on tapped v
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer, perform: { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.upstream.connect().cancel()
            }
        })
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards(storageManager: storageManager)
        }
        .onAppear(perform: resetCards)
    }
    
    private func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    private func loadData() {
        cards = storageManager.load()
    }
    
    private func removeCard(at index: Int) {
        guard index >= 0 else { return }
        self.cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    private func moveCardToBottom(index: Int) {
        guard !cards.isEmpty else { return }
        var updatedCards = cards
        let lastCard = updatedCards.removeLast()
        updatedCards.insert(lastCard, at: 0)
        cards = updatedCards
    }
}

#Preview {
    ContentView()
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}
