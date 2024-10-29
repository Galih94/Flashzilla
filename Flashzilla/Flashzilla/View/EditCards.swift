//
//  EditCards.swift
//  Flashzilla
//
//  Created by Galih Samudra on 28/10/24.
//

import SwiftUI

enum Config {
    static let CARDS_KEY: String = "Cards"
    static let SAVE_PATH = URL.documentsDirectory.appending(path: "SavedCards")
}

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    
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
        /// load by user data
//        if let data = UserDefaults.standard.data(forKey: Config.CARDS_KEY),
//           let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//            cards = decoded
//        }
        
        /// load by json local
        do {
            let data = try Data(contentsOf: Config.SAVE_PATH)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
    
    private func saveData() {
        /// save by user data
//        if let data = try? JSONEncoder().encode(cards) {
//            UserDefaults.standard.set(data, forKey: Config.CARDS_KEY)
//        }
        
        /// save by json local
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: Config.SAVE_PATH, options: [.atomic, .completeFileProtection])
        } catch {
            print("error -- \(error.localizedDescription)")
        }
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
    EditCards()
}
