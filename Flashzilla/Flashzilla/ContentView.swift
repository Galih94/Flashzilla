//
//  ContentView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor
    var body: some View {
        HStack {
            if diffWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            Text("success")
        }
        .padding()
        .background(diffWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}

#Preview {
    ContentView()
}
