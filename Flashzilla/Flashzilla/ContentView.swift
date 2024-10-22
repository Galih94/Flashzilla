//
//  ContentView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("world")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

#Preview {
    ContentView()
}
