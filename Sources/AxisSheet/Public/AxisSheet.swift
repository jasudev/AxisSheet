//
//  AxisSheet.swift
//  AxisSheet
//
//  Created by jasu on 2022/02/14.
//  Copyright (c) 2022 jasu All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import SwiftUI

/// A component that handles the sheet view in 4 directions (.top, .bottom, .leading, .trailing) according to the `ASAxisType`.
///
/// How to use the default header views:
///
///     AxisSheet(isPresented: $isPresented, constants: constants) {
///          Text("Content View")
///     }
///     /// or
///     Text("Content View")
///          .axisSheet(isPresented: $isPresented, constants: constants)
///
/// How to use custom header views:
///
///     AxisSheet(isPresented: $isPresented, constants: constants, header: {
///         Rectangle().fill(Color.red.opacity(0.5))
///             .overlay(Text("Header"))
///     }, content: {
///         Text("Content View")
///     })
///     /// or
///     Text("Content View")
///         .axisSheet(isPresented: $isPresented, constants: constants) {
///             Rectangle().fill(Color.red.opacity(0.5))
///                 .overlay(Text("Header"))
///         }
///
public struct AxisSheet<Header, Content>: View where Header: View, Content: View {
    
    /// Indicates whether a content is currently presented.
    @Binding var isPresented: Bool
    
    /// The axis type of the component.
    var constants: ASConstant
    
    /// The content of the header.
    private var header: (() -> Header)? = nil
    
    /// A view builder that creates content.
    @ViewBuilder private var content: () -> Content
    
    /// The total translation from the start of the drag gesture to the current event of the drag gesture.
    @GestureState private var translation: CGFloat = 0
    
    /// A value to restrict close.
    private let limitGap: CGFloat = 30
    
    //MARK: - property
    private var dragGesture: some Gesture {
        var max: CGFloat {
            switch constants.axisType {
            case .top, .leading: return constants.header.size - constants.size
            case .bottom, .trailing: return constants.size - constants.header.size
            }
        }
        return DragGesture().updating(self.$translation) { value, state, _ in
            state = getTranslationValue(value)
        }
        .onEnded { value in
            if isPresented {
                switch constants.axisType {
                case .top, .leading:
                    guard -getTranslationValue(value) > limitGap else { return }
                case .bottom, .trailing:
                    guard getTranslationValue(value) > limitGap else { return }
                }
            }
            self.isPresented = getPresentedValue(value)
        }
    }
    
    /// The position value according to the gesture.
    private var offset: CGFloat {
        var value: CGFloat = 0
        if !isPresented {
            if constants.presentationType == .minimize {
                value = constants.size
            }else {
                value = constants.size + constants.header.size
            }
        }
        switch constants.axisType {
        case .top, .leading: return -max(value - self.translation, 0)
        case .bottom, .trailing: return max(value + self.translation, 0)
        }
    }
    
    /// Transparency value based on position value.
    private var alpha: CGFloat {
        var value = 1.0 - abs(offset) / (constants.size)
        value = max(value, 0.0)
        value = min(value, 1.0)
        return value
    }
    
    /// Returns a shape with rounded corners according to the AxisType.
    private var cornerShape: some Shape {
        let radius = constants.header.cornerRadius
        switch constants.axisType {
        case .top:      return RoundCorner(bl: radius, br: radius)
        case .bottom:   return RoundCorner(tl: radius, tr: radius)
        case .leading:  return RoundCorner(tr: radius, br: radius)
        case .trailing: return RoundCorner(tl: radius, bl: radius)
        }
    }
    
    /// Header view.
    private var headerView: some View {
        let header = constants.header
        return ZStack {
            switch constants.axisType {
            case .top, .bottom:
                ZStack {
                    Rectangle()
                        .fill(header.backgroundColor)
                    if let header = self.header {
                        header()
                    }else {
                        Capsule()
                            .fill(header.color)
                            .frame(width: header.longAxis, height: header.shortAxis)
                    }
                }
                .frame(height: header.size)
            case .leading, .trailing:
                ZStack {
                    Rectangle()
                        .fill(header.backgroundColor)
                    if let header = self.header {
                        header()
                    }else {
                        Capsule()
                            .fill(header.color)
                            .frame(width: header.shortAxis, height: header.longAxis)
                    }
                }
                .frame(width: constants.header.size)
            }
        }
        .clipShape(cornerShape)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 0)
        .highPriorityGesture(dragGesture)
        .opacity(constants.presentationType == .minimize ? 1 : alpha == 0 ? 0 : 1)
        .onTapGesture {
            isPresented.toggle()
        }
    }
    
    /// Content view.
    private var contentView: some View {
#if os(iOS)
        ZStack {
            Color.clear
            self.content()
        }
        .opacity(alpha)
#else
        GeometryReader { proxy in
            ZStack {
                Color.clear
                self.content()
            }
            .disabled(alpha == 0)
            /// Handled as a contentShape due to a bug where the disabled modifier was not properly applied on macOS.
            .contentShape(ResizableRectangle(size: CGSize(width: proxy.size.width,
                                                          height: proxy.size.height * (alpha == 0 ? 0 : 1))))
        }
#endif
    }
    
    public var body: some View {
        let background = constants.background
        ZStack {
            background.color
                .opacity(background.disabled ? 0 : alpha)
                .edgesIgnoringSafeArea(.all)
                .animation(.linear(duration: 0.2), value: offset)
                .animation(.linear(duration: 0.2), value: background.disabled)
                .highPriorityGesture(dragGesture)
                .onTapGesture {
                    isPresented = false
                }
            getContent()
                .animation(.axisSheetAnimation, value: isPresented)
        }
        .animation(.axisSheetAnimation, value: alpha)
        .clipped()
    }
    
    //MARK: - method
    /// Returns a content view according to the `ASAxisType`.
    /// - Returns: A content view.
    private func getContent() -> some View {
        let contentSize = constants.size + constants.header.size
        return GeometryReader { proxy in
            switch constants.axisType {
            case .top:
                VStack(spacing: 0) {
                    self.contentView
                    self.headerView
                }
                .frame(width: proxy.size.width, height: contentSize)
                .frame(height: proxy.size.height, alignment: .top)
                .offset(y: offset)
            case .bottom:
                VStack(spacing: 0) {
                    self.headerView
                    self.contentView
                }
                .frame(width: proxy.size.width, height: contentSize)
                .frame(height: proxy.size.height, alignment: .bottom)
                .offset(y: offset)
            case .leading:
                HStack(spacing: 0) {
                    self.contentView
                    self.headerView
                }
                .frame(width: contentSize, height: proxy.size.height)
                .frame(width: proxy.size.width, alignment: .leading)
                .offset(x: offset)
            case .trailing:
                HStack(spacing: 0) {
                    self.headerView
                    self.contentView
                }
                .frame(width: contentSize, height: proxy.size.height)
                .frame(width: proxy.size.width, alignment: .trailing)
                .offset(x: offset)
            }
        }
    }
    
    /// Returns the isPresented value according to the drag gesture.
    /// - Parameter value: DragGesture.Value. `CGFloat`
    /// - Returns: Whether the content is exposed.
    private func getPresentedValue(_ value: DragGesture.Value) -> Bool {
        switch constants.axisType {
        case .top, .leading: return getTranslationValue(value) > 0
        case .bottom, .trailing: return getTranslationValue(value) < 0
        }
    }
    
    /// Returns the value of the gesture according to the `ASAxisType`.
    /// - Parameter value: DragGesture.Value `CGFloat`
    /// - Returns: The horizontal and vertical values of the gesture according to the `ASAxisType`.
    private func getTranslationValue(_ value: DragGesture.Value) -> CGFloat {
        switch constants.axisType {
        case .top, .bottom: return value.translation.height
        case .leading, .trailing: return value.translation.width
        }
    }
}

public extension AxisSheet where Header == EmptyView, Content : View {
    
    /// Initializes `AxisSheet`
    /// - Parameters:
    ///   - isPresented: Indicates whether a content is currently presented.
    ///   - constants: The axis type of the component.
    ///   - content: A view builder that creates content.
    init(isPresented: Binding<Bool>, constants: ASConstant = .init(), @ViewBuilder content: @escaping () -> Content) {
        _isPresented = isPresented
        self.constants = constants
        self.content = content
    }
}

public extension AxisSheet where Header : View, Content : View {
    
    /// Initializes `AxisSheet`
    /// - Parameters:
    ///   - isPresented: Indicates whether a content is currently presented.
    ///   - constants: The axis type of the component.
    ///   - header: The content of the header.
    ///   - content: A view builder that creates content.
    init(isPresented: Binding<Bool>, constants: ASConstant = .init(), @ViewBuilder header: @escaping () -> Header, @ViewBuilder content: @escaping () -> Content) {
        _isPresented = isPresented
        self.constants = constants
        self.header = header
        self.content = content
    }
}

struct AxisSheet_Previews: PreviewProvider {
    static var previews: some View {
        AxisSheet(isPresented: .constant(true)) {
            Text("AxisSheet")
        }
    }
}
