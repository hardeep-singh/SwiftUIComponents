//
//  ProgressBarsView.swift
//  SwiftUIComponents
//
//  Created by Hardeep Singh on 28/09/23.
//

import Foundation
import SwiftUI

struct ProgressBarsView: View {
    
    @StateObject var progressBarsViewModel: ProgressBarsViewModel = ProgressBarsViewModel()
   
    var body: some View {
        VStack {
            LinearProgressBar(viewModel: progressBarsViewModel.linearProgressBarViewModel)
                .frame(height: 30)
                .frame(maxWidth: .infinity)
            
            CircleProgressBar(viewModel: progressBarsViewModel.circleProgressBarViewModel)
                .frame(width: 200, height: 200)
            
            CircleProgressBar(viewModel: progressBarsViewModel.circleProgressBarViewDecreasing)
                .frame(width: 200, height: 200)
            
            SegmentProgressBar(viewModel: progressBarsViewModel.segmentProgressBarViewModel)
        }
        .padding()
        .onAppear() {
            progressBarsViewModel.startTimer()
        }
    }
}

#Preview {
    ProgressBarsView()
}
