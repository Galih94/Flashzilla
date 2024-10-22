//
//  ContentView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    var body: some View {
        Text("Text")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(RotateGesture()
                .onChanged{ value in
                    currentAmount = value.rotation
                }
                .onEnded{ value in
                    finalAmount += currentAmount
                    currentAmount = .zero
                })
    }
}

#Preview {
    ContentView()
}
