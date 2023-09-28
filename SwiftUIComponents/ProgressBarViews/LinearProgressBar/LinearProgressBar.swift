//
//  ProgressBar.swift
//  UIComponents
//
//  Created by Hardeep Singh on 21/09/21.
//

import SwiftUI

struct LinearProgressBar: View {
    
    @ObservedObject var viewModel: LinearProgressBarViewModel
    private var closedRange: ClosedRange<Float> = 0.0...1.0 // defuatl range..

    var backgroundColor: Color = .green
    var forgroundColor: Color = .orange

    init(viewModel: LinearProgressBarViewModel) {
        self.viewModel = viewModel
    }
    
    private func radius(geometry: GeometryProxy) -> CGFloat {
        return (geometry.size.height * 0.6)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: radius(geometry: geometry)).frame(width: geometry.size.width,
                                  height: geometry.size.height)
                    .opacity(1.0)
                    .foregroundColor(backgroundColor)
                RoundedRectangle(cornerRadius: radius(geometry: geometry)).frame(width:
                                    progress(value: viewModel.value,
                                             maxValue: closedRange.upperBound,
                                             width: geometry.size.width),
                                  height: geometry.size.height)
                    .foregroundColor(forgroundColor)
            }.overlay(
                RoundedRectangle(cornerRadius: radius(geometry: geometry))
                    .stroke(Color.black, lineWidth: 0.4)
            )
           
        }
    }
    
    private func progress(value: Double,
                          maxValue: Float,
                          width: CGFloat) -> CGFloat {
        let percentage = Float(value) / maxValue
        return width *  CGFloat(percentage)
    }
    
}

//struct LinearProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        LinearProgressBar(viewModel: .init(range: 0...1.0, currentValue: 0.5))
//    }
//}
