//
//  Card.swift
//  Flashzilla
//
//  Created by Galih Samudra on 24/10/24.
//

import Foundation

struct Card {
    var prompt: String
    var answer: String
    
    static let example = Card(
        prompt: "Who played the 13th Doctor in Doctor Who?",
        answer: "Jodie Whittaker")
}
