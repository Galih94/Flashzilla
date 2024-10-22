//
//  ContentView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped")
                }
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Circle tapped")
                }
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    ContentView()
}
