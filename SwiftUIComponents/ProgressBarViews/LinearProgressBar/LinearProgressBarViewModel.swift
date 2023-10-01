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
    @Published var progress: Double = 0.5
    private(set) var range: ClosedRange<Double> = 0.0...1.0 // defuatl range..
    private var currentValue: Double!
        
    init(value: Double, in range: ClosedRange<Double>) {
        self.id = UUID()
        self.range = range
        self.setProgress(value: value)
    }
    
    func setProgress(value: Double) {
        currentValue = value
        if range.contains(value) {
            let _value = (value -  range.lowerBound) / (range.upperBound - range.lowerBound)
            self.progress = _value
        } else if value < range.lowerBound {
            self.progress = 0.0
        } else {
            self.progress = 1.0
        }
    }
    
}
