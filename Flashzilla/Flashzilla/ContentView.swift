//
//  ContentView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var schenPhase
    var body: some View {
        Text("Hello world")
            .onChange(of: schenPhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("active")
                } else if newPhase == .inactive {
                    print("inactive")
                } else if newPhase == .background {
                    print("background")
                }
            }
    }
}

#Preview {
    ContentView()
}
