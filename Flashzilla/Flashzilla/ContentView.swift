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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("double")
                .onTapGesture(count: 2, perform: {
                    print("double tapped")
                })
            Text("long")
                .onLongPressGesture(perform: {
                    print("long tapped")
                })
            Text("long duration 2")
                .onLongPressGesture(minimumDuration: 2, perform: {
                    print("long tapped 2 second")
                })
            Text("detect pressing changed")
                .onLongPressGesture(minimumDuration: 2, perform: {
                    print("long tapped for 2 second")
                }, onPressingChanged: { inProgress in
                    print("long tapped in progress \(inProgress)")
                })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
