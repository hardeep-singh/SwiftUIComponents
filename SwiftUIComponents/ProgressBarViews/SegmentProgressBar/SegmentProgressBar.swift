//
//  SegmentProgressBar.swift
//  UIComponents
//
//  Created by Hardeep Singh on 21/09/21.
//

import SwiftUI

struct SegmentProgressBar: View {
    
    @ObservedObject var viewModel: SegmentProgressBarViewModel
    @State var value: Float  = 0.5

    private func spacing(_ geometryProxy: GeometryProxy, oldSpacing: CGFloat = 20) -> CGFloat {
        let width = geometryProxy.size.width
        if width > 1080 {
            let aspectRation = (oldSpacing / 1080)
            return width * aspectRation
        }
        return oldSpacing
    }
    
    private func widthToFloat(_ geometryProxy: GeometryProxy) -> Float {
        return Float(geometryProxy.size.width)
    }
    
    private func barWidth(_ geometryProxy: GeometryProxy, barViewModel: LinearProgressBarViewModel) -> CGFloat {
        return CGFloat(viewModel.widthForSegment(screenWidth: widthToFloat(geometryProxy),
                                                padding: Float(spacing(geometryProxy)),
                                                model: barViewModel))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear.edgesIgnoringSafeArea(.all)
                HStack(alignment: .center, spacing: spacing(geometry)) {
                    ForEach(viewModel.progressBarViewModels, id: \.self) { progressBarViewModel in
                        VStack(alignment: .center) {
                            LinearProgressBar(viewModel: progressBarViewModel)
                                .frame(width: barWidth( geometry, barViewModel: progressBarViewModel), height: geometry.size.height)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}
