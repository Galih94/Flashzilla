//
//  ContentView.swift
//  Flashzilla
//
//  Created by Galih Samudra on 22/10/24.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    var body: some View {
        Text("Hello world")
            .onReceive(timer, perform: { time in
                if counter > 4 {
                    timer.upstream.connect().cancel()
                } else {
                    print("time is: \(time)")
                }
                counter += 1
            })
    }
}

#Preview {
    ContentView()
}
import SwiftUI
