//
//  SheetSlider.swift
//  AxisSheetExample
//
//  Created by jasu on 2022/02/16.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI

struct SheetSlider: View {
    
    let title: String
    @Binding var value: CGFloat
    let range: ClosedRange<CGFloat>
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("\(value, specifier: "%.2f")")
                .font(.caption)
                .opacity(0.5)
            HStack {
                Text(title)
                Slider(value: $value, in: range)
            }
        }
    }
}

struct SheetSlider_Previews: PreviewProvider {
    static var previews: some View {
        SheetSlider(title: "Slider", value: .constant(0.5), range: 0.0...3.0)
    }
}
