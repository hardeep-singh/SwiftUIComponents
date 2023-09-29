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
            LinearProgressBar(viewModel: .init(value: 0.5, in: 0.0...1.0, step: 0.1))
                .frame(height: 30).frame(maxWidth: .infinity)
            
            CircleProgressBar(viewModel: .init(value: 0.8, in: 0.0...1.0, increasingOrder: false))
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

#Preview {
    ProgressBarsView()
}
