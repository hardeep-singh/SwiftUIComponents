//
//  CircleProgressBar.swift
//  UIComponents
//
//  Created by Hardeep Singh on 20/09/21.
//

import SwiftUI

struct CircleProgressBar: View {
    
    @ObservedObject var viewModel: CircleProgressBarViewModel
//    @State var fontSize: CGFloat = 50
    
    @State var customize: CustomUI = CustomUI()
    
    struct CustomUI {
        
        var fontSize: CGFloat = 50
        
        var progressBarColor: Color = .red
        var barColor: Color = .gray
        var textColor: Color = .gray
        
        var progressBarWidth: CGFloat = 3
        var barWidth: CGFloat = 3
        
        var circelPadding: CGFloat = 3
        
        static func customize(fontSize: CGFloat,
                              progressBarColor: Color,
                              barColor: Color,
                              textColor: Color,
                              progressBarWidth: CGFloat,
                              barWidth: CGFloat,
                              circelPadding: CGFloat) -> CustomUI {
            CustomUI(fontSize: fontSize,
                     progressBarColor: progressBarColor,
                     barColor: barColor,
                     textColor: textColor,
                     progressBarWidth: progressBarWidth,
                     barWidth: barWidth,
                     circelPadding: circelPadding)
        }
    }
    
    init(viewModel: CircleProgressBarViewModel, customize: () -> (CustomUI)) {
        self.customize = customize()
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: customize.barWidth)
                        .foregroundColor(customize.barColor)
                        .opacity(0.7)
                        .padding(customize.progressBarWidth + customize.circelPadding)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(viewModel.value))
                        .stroke(style: StrokeStyle(lineWidth: customize.progressBarWidth, lineCap: .butt, lineJoin: .bevel))
                        .foregroundColor(customize.progressBarColor)
                    
                    Slider(progress: $viewModel.value,
                           sliderColor: customize.progressBarColor,
                           sliderWidth: customize.progressBarWidth)
                        .frame(width: 25, height: 25)
                        .offset(x: (geometry.size.width) / 2)
                    
                    Slider(progress: .constant(0),
                           sliderColor: customize.progressBarColor,
                           sliderWidth: customize.progressBarWidth)
                        .frame(width: 25, height: 25)
                        .offset(x: (geometry.size.width) / 2)
                        .rotationEffect(.init(degrees: Double(viewModel.value * 360)))
                }
                .rotationEffect(.init(degrees: 270))
                
                Text(viewModel.text)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .font(.bold(size: customize.fontSize))
                    //.font(Font.custom("Avenir-Heavy", size: customize.fontSize, relativeTo: .title))
                    .foregroundColor(customize.textColor)
                    .padding([.horizontal], (customize.barWidth + customize.progressBarWidth + customize.circelPadding))
                    .shadow(color: .black.opacity(0.8), radius: 1, x: 0.2, y: 0.5)


            }
        }
    }
}

fileprivate struct Slider: View {
    @Binding var progress: Float
    var sliderColor: Color
    var sliderWidth: CGFloat
    init(progress: Binding<Float>, sliderColor: Color, sliderWidth: CGFloat) {
        self.sliderWidth = sliderWidth
        self.sliderColor = sliderColor
        _progress = progress
    }
    var body: some View {
        ZStack {
            Circle()
                .fill(sliderColor)
                .frame(width: (sliderWidth * 2), height: (sliderWidth * 2))
            Circle()
                .fill(Color.white)
                .frame(width: sliderWidth, height: sliderWidth)
                .padding(1.5)
        }
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct CustomFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    var name: String
    var style: UIFont.TextStyle
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        return content.font(Font.custom(
            name,
            size: UIFont.preferredFont(forTextStyle: style).pointSize)
            .weight(weight))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func customFont(
        name: String,
        style: UIFont.TextStyle,
        weight: Font.Weight = .regular) -> some View {
        return self.modifier(CustomFont(name: name, style: style, weight: weight))
    }
}

extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 1, blur: CGFloat = 6) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))
        
        return self
            .overlay(
                shape
                    .stroke(color, lineWidth: width)
                    .offset(x: finalX * width * 0.5, y: finalY * width * 0.5)
                    .blur(radius: blur)
                    .mask(shape)
            )
    }
}
