//
//  SegmentProgressBarViewModel.swift
//  UIComponents
//
//  Created by Hardeep Singh on 21/09/21.
//

import Foundation

class SegmentProgressBarViewModel: ObservableObject {
   
    private(set) var totalDuration: Seconds
    
    @Published var progressBarViewModels: [LinearProgressBarViewModel]
    var currentProgressBarViewModel: LinearProgressBarViewModel?
    
    var count: Int {
        return progressBarViewModels.count
    }
    
    init(totalDuration: Seconds, segments: [LinearProgressBarViewModel]) {
        self.totalDuration = totalDuration
        self.progressBarViewModels = segments
    }
    
    private func getCurrentSegment(seconds: Seconds) -> LinearProgressBarViewModel? {
       _ = progressBarViewModels.map() {
            if seconds > Int($0.range.upperBound) {
                $0.progress = 1.0
            } else if seconds < Int($0.range.lowerBound) {
                $0.progress = 0.0
            }
        }
        return progressBarViewModels.first { $0.range.contains(Double(seconds)) }
    }
    
    func setProgress(seconds: Seconds) {
        
        if let currentProgressBarViewModel = self.currentProgressBarViewModel,
            currentProgressBarViewModel.range.contains(Double(seconds)) {
            
            currentProgressBarViewModel.setProgress(value: Double(seconds))

        } else {
            if let nextProgressBarViewModel = getCurrentSegment(seconds: seconds) {
                self.currentProgressBarViewModel = nextProgressBarViewModel
            }
            currentProgressBarViewModel?.setProgress(value: Double(seconds))
        }
        
        
    }
    
    typealias Seconds = Int64

    func widthForSegment(screenWidth: Float, padding: Float, model: LinearProgressBarViewModel) -> Float {
        let spacing = (padding * Float(max(count - 1, 0)))
        let maxWidth = (screenWidth - spacing)
        
        let value = (model.range.upperBound - model.range.lowerBound)
        let precentage: Float = Float(value) / Float(totalDuration)
        return (maxWidth * precentage)
        
    }
        
}

extension LinearProgressBarViewModel: Hashable, Identifiable {
     static func == (lhs: LinearProgressBarViewModel, rhs: LinearProgressBarViewModel) -> Bool {
         return lhs.id == rhs.id
     }
     
     func hash(into hasher: inout Hasher) {
         hasher.combine(id)
     }
}
