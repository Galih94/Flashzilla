//
//  EditCards.swift
//  Flashzilla
//
//  Created by Galih Samudra on 28/10/24.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    let storageManager: iStorageManager
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card") {
                        addCard()
                    }
                }
                Section("Add new card") {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete { indexSet in
                        removeCards(at: indexSet)
                    }
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done") {
                    done()
                }
            }
            .onAppear {
                loadData()
            }
        }
    }
    
    private func done() {
        dismiss()
    }
    
    private func loadData() {
        cards = storageManager.load()
    }
    
    private func saveData() {
        storageManager.save(cards)
    }
    
    private func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedPrompt.isEmpty, !trimmedAnswer.isEmpty else { return }
        let newCard = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(newCard, at: 0)
        newPrompt = ""
        newAnswer = ""
        saveData()
    }
    
    private func removeCards(at offset: IndexSet) {
        cards.remove(atOffsets: offset)
        saveData()
    }
}

#Preview {
    EditCards(storageManager: StorageManager())
}
