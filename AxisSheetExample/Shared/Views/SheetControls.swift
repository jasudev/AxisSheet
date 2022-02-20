//
//  SheetControls.swift
//  AxisSheetExample
//
//  Created by jasu on 2022/02/16.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSheet

struct SheetControls: View {
    
    @Binding var isPresented: Bool
    @Binding var constants: ASConstant
    @Binding var isCustomHeader: Bool
    
    var body: some View {
        HStack {
            Toggle("", isOn: $isPresented)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .labelsHidden()
            VStack(alignment: .trailing) {
                Picker("", selection: $constants.axisMode) {
                    Image(systemName: "rectangle.bottomthird.inset.filled").tag(ASAxisMode.bottom)
                    Image(systemName: "rectangle.rightthird.inset.filled").tag(ASAxisMode.trailing)
                    Image(systemName: "rectangle.leadingthird.inset.filled").tag(ASAxisMode.leading)
                    Image(systemName: "rectangle.topthird.inset.filled").tag(ASAxisMode.top)
                }
                Picker("", selection: $constants.presentationMode) {
                    Text("Minimize").tag(ASPresentationMode.minimize)
                    Text("Hide").tag(ASPresentationMode.hide)
                }
                Picker("", selection: $isCustomHeader) {
                    Text("Normal").tag(false)
                    Text("Custom Header").tag(true)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }
}

struct SheetControls_Previews: PreviewProvider {
    static var previews: some View {
        SheetControls(isPresented: .constant(true),
                          constants: .constant(ASConstant()),
                          isCustomHeader: .constant(false))
    }
}
