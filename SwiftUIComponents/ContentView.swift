//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Hardeep Singh on 28/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ProgressBarsView()
                .frame(maxWidth:.infinity, maxHeight: .infinity)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
