//
//  CircleProgressBarViewModel.swift
//  UIComponents
//
//  Created by Hardeep Singh on 20/09/21.
//

import Combine

internal class CircleProgressBarViewModel: ObservableObject {
    
    // range 0 to 1.
    @Published var value: Float = 1.0
    @Published var text: String = ""
    
    private var range: ClosedRange<Double>!
    private var currentValue: Double!
    private var increasingOrder: Bool = false
    
    init(currentValue: Double = 0.0, range: ClosedRange<Double> = 0.0...1.0, increasingOrder: Bool = false) {
        self.range = range
        self.increasingOrder = increasingOrder
        self.value = progressOrder(value: Float(currentValue))
    }
    
    private func progressOrder(value: Float) -> Float {
        return increasingOrder ? Float(value) : (1.0 - Float(value))
    }
    
    func timeToShow(range: ClosedRange<Double>, currentValue: Double) -> String  {
        let seconds = Seconds(max(range.upperBound - currentValue, 0.0))
        let (h, m, s) = Tribe.secondsToHoursMinutesSeconds(seconds: seconds)
        var timeString = "0"
        if h > 0 {
            timeString = String(format: "%i:%02i:%02i", h, m, s)
        } else if m > 0 {
            timeString = String(format: "%02i:%02i", m, s)
        } else {
            timeString = String(format: "%02i", s)
        }
        return timeString
    }
    
    func setProgress(range: ClosedRange<Double>, currentValue: Double, text: String) {
        
        self.text = timeToShow(range: range, currentValue: currentValue)

        if range.contains(currentValue) {
            let _value = (currentValue -  range.lowerBound) / (range.upperBound - range.lowerBound)
            if _value.isNaN {
                return
            }
            self.value = progressOrder(value: Float(_value)) //increasingOrder ? Float(_value) : (1.0 - Float(_value))

        } else if currentValue < range.lowerBound {
            self.value = 0.0
        } else {
            self.value = 1.0
        }
    }
    
}


