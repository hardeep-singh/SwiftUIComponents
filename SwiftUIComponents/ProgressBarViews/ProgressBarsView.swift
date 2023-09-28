//
//  ProgressBarsView.swift
//  SwiftUIComponents
//
//  Created by Hardeep Singh on 28/09/23.
//

import Foundation

import SwiftUI

struct ProgressBarsView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            LinearProgressBar(viewModel: .init(duration: 0.1, range: 0.0...1.0, currentValue: 0.5)).frame(height: 30).frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    ProgressBarsView()
}
