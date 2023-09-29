//
//  ProgressBarViewModel.swift
//  FitClubApp
//
//  Created by Hardeep Singh on 23/09/21.
//  Copyright © 2021 FitClub. All rights reserved.
//

import Foundation

internal class LinearProgressBarViewModel: ObservableObject {
   
    var id: UUID
    
    private(set) var duration: Double
    @Published var progress: Double = 0.5
    private(set) var range: ClosedRange<Double> = 0.0...1.0 // defuatl range..
    private var currentValue: Double!
        
    // value: $value,
    ///                     in: range,
    ///                     step: step)
    ///                       
    ///
    init(value: Double, in range: ClosedRange<Double>, step: Double = 0.0) {
        self.id = UUID()
        self.duration = step
        self.range = range
        self.setProgress(currentValue: value)
    }

//    init(duration: Double, range: ClosedRange<Double>, currentValue: Double = 0.0) {
//        self.id = UUID()
//        self.duration = duration
//        self.range = range
//        self.setProgress(currentValue: currentValue)
//    }
    
    func setProgress(currentValue: Double) {
        if range.contains(currentValue) {
            let _value = (currentValue -  range.lowerBound) / (range.upperBound - range.lowerBound)
            self.progress = _value
        } else if currentValue < range.lowerBound {
            self.progress = 0.0
        } else {
            self.progress = 1.0
        }
    }
    
}
