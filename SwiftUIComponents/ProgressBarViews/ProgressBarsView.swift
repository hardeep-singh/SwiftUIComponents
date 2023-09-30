//
//  ProgressBarsView.swift
//  SwiftUIComponents
//
//  Created by Hardeep Singh on 28/09/23.
//

import Foundation

import SwiftUI

let segmentProgressBarViewModel = SegmentProgressBarViewModel.init(totalDuration: 60,
                                                                   segments: [.init(value: 30, in: 0.0...30),
                                                                              .init(value: 30, in: 31...60)])
struct ProgressBarsView: View {
    let segmentProgressBar: SegmentProgressBar! = SegmentProgressBar(viewModel: segmentProgressBarViewModel)
    var body: some View {
        VStack {
            LinearProgressBar(viewModel: .init(value: 0.5, in: 0.0...1.0))
                .frame(height: 30).frame(maxWidth: .infinity)
            
            CircleProgressBar(viewModel: .init(value: 0.8, in: 0.0...1.0, increasingOrder: false))
                .frame(width: 200, height: 200)
            
            segmentProgressBar
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        

        }
        .padding()
        .onAppear() {
            segmentProgressBarViewModel.setProgress(seconds: 31)
        }
    }
}

#Preview {
    ProgressBarsView()
}
