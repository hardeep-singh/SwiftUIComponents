//
//  CircleProgressBarViewModel.swift
//  UIComponents
//
//  Created by Hardeep Singh on 20/09/21.
//

import Combine

//typealias Seconds = Int64

internal class CircleProgressBarViewModel: ObservableObject {
    
    // range 0 to 1.
    @Published var progress: Float = 1.0
    @Published var text: String = ""
    
    private var range: ClosedRange<Double>!
    private var currentValue: Double!
    private var increasingOrder: Bool = true
    
    init(value: Double = 0.0,
         in range: ClosedRange<Double> = 0.0...1.0,
         increasingOrder: Bool = true) {
        self.range = range
        self.increasingOrder = increasingOrder
        self.progress = progressOrder(value: Float(value))
    }
    
    private func progressOrder(value: Float) -> Float {
        return increasingOrder ? Float(value) : (1.0 - Float(value))
    }
    
//    static func secondsToHoursMinutesSeconds(seconds : Seconds) -> (Seconds, Seconds, Seconds) {
//      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
//    }
//    
//    func timeToShow(range: ClosedRange<Double>, currentValue: Double) -> String  {
//        let seconds = Seconds(max(range.upperBound - currentValue, 0.0))
//        let (h, m, s) = Self.secondsToHoursMinutesSeconds(seconds: seconds)
//        var timeString = "0"
//        if h > 0 {
//            timeString = String(format: "%i:%02i:%02i", h, m, s)
//        } else if m > 0 {
//            timeString = String(format: "%02i:%02i", m, s)
//        } else {
//            timeString = String(format: "%02i", s)
//        }
//        return timeString
//    }
    
    func setProgress(value: Double, text: String = "") {
        
        self.text = text

        if range.contains(value) {
            let _value: Double = (value -  range.lowerBound) / (range.upperBound - range.lowerBound)
            if _value.isNaN {
                return
            }
            self.progress = progressOrder(value: Float(_value))

        } else if value < range.lowerBound {
            self.progress = 0.0
        } else {
            self.progress = 1.0
        }
    }
    
}


