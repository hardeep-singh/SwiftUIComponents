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
    
    private(set) var duration: Float
    @Published var value: Float = 0.5
    private(set) var range: ClosedRange<Double> = 0.0...1.0 // defuatl range..
    private var currentValue: Double!
        
    init(duration: Float, range: ClosedRange<Double>, currentValue: Double = 0.0) {
        self.id = UUID()
        self.duration = duration
        self.range = range
        self.setProgress(currentValue: currentValue)
    }
    
    func setProgress(currentValue: Double) {
        if range.contains(currentValue) {
            let _value = (currentValue -  range.lowerBound) / (range.upperBound - range.lowerBound)
            self.value = Float(_value)
        } else if currentValue < range.lowerBound {
            self.value = 0.0
        } else {
            self.value = 1.0
        }
    }
    
}
