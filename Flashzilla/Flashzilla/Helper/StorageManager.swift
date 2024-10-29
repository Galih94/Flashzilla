//
//  StorageManager.swift
//  Flashzilla
//
//  Created by Galih Samudra on 29/10/24.
//

import Foundation

enum Config {
    static let CARDS_KEY: String = "Cards"
    static let SAVE_PATH = URL.documentsDirectory.appending(path: "SavedCards")
}

protocol iStorageManager {
    func load() -> [Card]
    func save(_ cards: [Card])
}

struct StorageManager: iStorageManager {
    func load() -> [Card] {
        /// load by user data
//        if let data = UserDefaults.standard.data(forKey: Config.CARDS_KEY),
//           let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//            cards = decoded
//        }
        
        /// load by json local
        do {
            let data = try Data(contentsOf: Config.SAVE_PATH)
            return try JSONDecoder().decode([Card].self, from: data)
        } catch {
            return []
        }
    }
    
    func save(_ cards: [Card]) {
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
}
