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
            
            SegmentProgressBar(viewModel: progressBarsViewModel.segmentProgressBarViewModel)
                .frame(height: 30)
                .frame(maxWidth: .infinity)
                .background(Color.purple)
            
            CircleProgressBar(viewModel: progressBarsViewModel.circleProgressBarViewModel)
                .frame(width: 200, height: 200)
            
            CircleProgressBar(viewModel: progressBarsViewModel.circleProgressBarViewDecreasing)
                .frame(width: 200, height: 200)
            
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
