//
//  ContentView.swift
//  AxisSheetExample
//
//  Created by jasu on 2022/02/14.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisSheet

struct ContentView: View {
    
    @State private var isPresented: Bool = false
#if os(iOS)
    @State private var constants = ASConstant()
#else
    @State private var constants = ASConstant(size: 300, header: ASHeaderConstant(size: 50))
#endif
    @State private var isCustomHeader: Bool = false
    
    private var customHeader: some View {
        Rectangle().fill(Color.red.opacity(0.5))
            .overlay(
                HStack {
                    Text("Header")
                        .frame(width: 160)
                        .foregroundColor(.white)
                        .rotationEffect(getHeaderAngle())
                }
            )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SheetControls(isPresented: $isPresented,
                          constants: $constants,
                          isCustomHeader: $isCustomHeader)
                .padding()
            ZStack {
                VStack {
                    Text("AxisSheet")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("for SwiftUI")
                        .font(.headline)
                        .opacity(0.5)
                }
                .foregroundColor(.accentColor)
                .offset(getOffset())
                if !isCustomHeader {
                    SheetConstants(constants: $constants)
                        .axisSheet(isPresented: $isPresented, constants: constants)
//                    /// or
//                    AxisSheet(isPresented: $isPresented, constants: constants) {
//                        SheetConstants(constants: $constants)
//                    }
                }else {
                    SheetConstants(constants: $constants)
                        .axisSheet(isPresented: $isPresented, constants: constants) {
                            customHeader
                        }
//                    /// or
//                    AxisSheet(isPresented: $isPresented, constants: constants, header: {
//                        customHeader
//                    }, content: {
//                        SheetConstants(constants: $constants)
//                    })
                }
            }
            .background(Color.blue.opacity(0.26))
            .animation(.easeOut(duration: 0.2), value: constants)
        }
    }
    
    private func getHeaderAngle() -> Angle {
        switch constants.axisMode {
        case .top, .bottom: return Angle(degrees: 0)
        case .leading: return Angle(degrees: 90)
        case .trailing: return Angle(degrees: -90)
        }
    }
    
    private func getOffset() -> CGSize {
        guard constants.presentationMode == .minimize else {
            return .zero
        }
        switch constants.axisMode {
        case .top:       return CGSize(width: 0, height: constants.header.size)
        case .bottom:    return CGSize(width: 0, height: -constants.header.size)
        case .leading:   return CGSize(width: constants.header.size, height: 0)
        case .trailing:  return CGSize(width: -constants.header.size, height: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
