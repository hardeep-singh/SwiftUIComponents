//
//  ScrollViewIfNeeded.swift
//  SwiftHelpers
//
//  Created by Hardeep Singh on 18/12/2024.
//

import SwiftUI

private extension View {
    @ViewBuilder
    func applyScrollViewIfNeeded(_ condition: Bool,
                                 axes: Axis.Set = .vertical,
                                 showsIndicators: Bool = false) -> some View {
        if condition {
            ScrollView(axes, showsIndicators: showsIndicators) { self }
        } else {
            self
        }
    }
}

struct AdaptiveScrollView<Content> : View where Content : View {
    
    @State private var isOverflowing: Bool = false
    public var content: Content
    public var axes: Axis.Set
    public var showsIndicators: Bool
    init(axes: Axis.Set = .vertical,
         showsIndicators: Bool = false, @ViewBuilder _ content: () -> Content) {
        self.content = content()
        self.axes = axes
        self.showsIndicators = showsIndicators
    }
    
    var body: some View {
        GeometryReader { parentGeometry in
            ZStack {
                content
                    .background(
                        GeometryReader { contentGeometry in
                            Color.clear.onAppear {
                                // Determine if content size exceeds parent size
                                isOverflowing = contentGeometry.size.height > parentGeometry.size.height
                            }
                        }
                    ).applyScrollViewIfNeeded(isOverflowing)
            }.frame(
                width: parentGeometry.frame(in: .global).width,
                height: parentGeometry.frame(in: .global).height)
        }
    }
    
}

private struct AdaptiveScrollViewModifier: ViewModifier {
    
    private let axes: Axis.Set
    private let showsIndicators: Bool
    @State private var isOverflowing: Bool = false
    
    init(axes: Axis.Set = .vertical,
         showsIndicators: Bool = false) {
        self.axes = axes
        self.showsIndicators = showsIndicators
    }
    
    func body(content: Content) -> some View {
        AdaptiveScrollView(
            axes: axes,
            showsIndicators: showsIndicators, { content }
        )
    }
    
}

extension View {
    /// Wraps the content in a ScrollView if it overflows the parent's bounds.
    func adaptiveScroll(axes: Axis.Set = .vertical,
                        showsIndicators: Bool = false) -> some View {
        modifier(AdaptiveScrollViewModifier(axes: axes, showsIndicators: showsIndicators))
    }
}
