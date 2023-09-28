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
        }
        .padding()
    }
}

#Preview {
    ProgressBarsView()
}
