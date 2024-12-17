//
//  AdaptiveScrollViewExample.swift
//  SwiftUIComponents
//
//  Created by Hardeep Singh on 18/12/2024.
//

import SwiftUI

private struct ComputeData {
    static let data: [Int] = Array(1...40).map(\.self)
    static let data2: [Int] = Array(1...34).map(\.self)
}


struct AdaptiveScrollViewExample: View {
    var body: some View {
        HStack {
           
            AdaptiveScrollView {
                VStack {
                    Text("Example: 1")
                        .padding(.bottom, 10)
                    ForEach(ComputeData.data2, id: \.self) { int in
                        Text("Item: \(int)")
                    }
                    Spacer()
                }
            }
            .background(Color.gray.opacity(0.1))
            
            AdaptiveScrollView {
                VStack {
                    Text("Example: 2")
                        .padding(.bottom, 10)
                    ForEach(ComputeData.data, id: \.self) { int in
                        Text("Item: \(int)")
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
            
            VStack {
                Text("Example: 3")
                    .padding(.bottom, 10)
                ForEach(ComputeData.data, id: \.self) { int in
                    Text("Item: \(int)")
                }
            }.adaptiveScroll(showsIndicators: true)
            .background(Color.gray.opacity(0.1))
        }
       
    }
}

#Preview {
    AdaptiveScrollViewExample()
}
