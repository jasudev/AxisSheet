//
//  SheetConstants.swift
//  AxisSheetExample
//
//  Created by jasu on 2022/02/16.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSheet

struct SheetConstants: View {
    
    @Binding var constants: ASConstant
    
    init(constants: Binding<ASConstant>) {
        _constants = constants
#if os(iOS)
        UITableView.appearance().backgroundColor = .clear
#endif
    }
    
    var content: some View {
        Group {
            Section(header: Text("Header").foregroundColor(.accentColor)) {
                SheetSlider(title: "size", value: $constants.header.size, range: 24...70)
                SheetSlider(title: "shortAxis", value: $constants.header.shortAxis, range: 0...10)
                SheetSlider(title: "longAxis", value: $constants.header.longAxis, range: 0...80)
                SheetSlider(title: "radius", value: $constants.header.cornerRadius, range: 0...(constants.header.size / 2))
                ColorPicker("foregroundColor", selection: $constants.header.color)
                ColorPicker("backgroundColor", selection: $constants.header.backgroundColor)
            }
            
            Section(header: Text("Content").foregroundColor(.accentColor)) {
                SheetSlider(title: "size", value: $constants.size, range: 200...500)
            }
            
            Section(header: Text("Background").foregroundColor(.accentColor)) {
                Toggle("disabled", isOn: $constants.background.disabled)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                ColorPicker("color", selection: $constants.background.color)
            }
        }
        .foregroundColor(Color.white)
        .listRowBackground(Color.clear)
    }
    var body: some View {
        ZStack {
#if os(iOS)
            Form {
                content
            }
#else
            ScrollView {
                Form {
                    content
                }
                .padding()
            }
#endif
        }
        .background(
            ZStack {
                Color.gray
                Color.black.opacity(0.75)
            }
        )
    }
}

struct SheetConstants_Previews: PreviewProvider {
    static var previews: some View {
        SheetConstants(constants: .constant(ASConstant()))
    }
}
