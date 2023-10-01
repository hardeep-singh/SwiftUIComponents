//
//  ProgressBarsViewModel.swift
//  SwiftUIComponents
//
//  Created by Hardeep Singh on 01/10/23.
//

import Foundation
import Combine


class ProgressBarsViewModel: ObservableObject {
    
    var linearProgressBarViewModel: LinearProgressBarViewModel!
    var circleProgressBarViewModel: CircleProgressBarViewModel!
    var circleProgressBarViewDecreasing: CircleProgressBarViewModel!

    var segmentProgressBarViewModel: SegmentProgressBarViewModel!
    
    var counter: Int = 0
    var subscriptions = Set<AnyCancellable>()

    init() {
        
        // Linear progress bar view model
        linearProgressBarViewModel = LinearProgressBarViewModel(value: 0, in: 0...100)
        
        // Circle progress bar view model...
        circleProgressBarViewModel = CircleProgressBarViewModel(value: 0, in: 0...100, increasingOrder: true)
        
        circleProgressBarViewDecreasing = CircleProgressBarViewModel(value: 0, in: 0...100, increasingOrder: false)

        // Segmented progress bar view model
        segmentProgressBarViewModel = SegmentProgressBarViewModel(totalDuration: 100,
                                                                  segments: [.init(value: 0, in: 0...25),
                                                                             .init(value: 26, in: 26...70),
                                                                             .init(value: 71, in: 71...100)])
    }
    
    func startTimer() {
        Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .sink { value in
                print(value)
                self.updateViewModels()
            }.store(in: &subscriptions)
    }
    
    func updateViewModels() {
        linearProgressBarViewModel.setProgress(currentValue: Double(counter))
        
        
        circleProgressBarViewModel.setProgress(value: Double(counter), text: "Increasing Order", in: 0...100)
        circleProgressBarViewDecreasing.setProgress(value: Double(counter), text: "Decreasing Order", in: 0...100)

        segmentProgressBarViewModel.setProgress(seconds: SegmentProgressBarViewModel.Seconds(counter))
        
        if counter == 100 {
            counter = 0
        }
        counter += 1
    }
    
}
