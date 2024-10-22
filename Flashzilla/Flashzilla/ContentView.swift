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
            
            Text("Text")
                .onTapGesture {
                    print("text tapped")
                }
        }
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

#Preview {
    ContentView()
}
