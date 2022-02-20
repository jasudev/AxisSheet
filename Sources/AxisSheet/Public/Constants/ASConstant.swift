//
//  ASConstant.swift
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

/// The axis mode of the component.
public enum ASAxisMode {
    case top
    case bottom
    case leading
    case trailing
}

/// The mode of whether to expose the component when the isPresented value is false.
public enum ASPresentationMode {
    case hide
    case minimize
}

/// The component status information.
public struct ASConstant: Equatable {
    
    /// The axis mode of the component.
    public var axisMode: ASAxisMode
    
    /// The size of the content.
    public var size: CGFloat
    
    /// The mode of whether to expose the component when the isPresented value is false.
    public var presentationMode: ASPresentationMode
    
    /// The header status information.
    public var header: ASHeaderConstant
    
    /// The component background status information.
    public var background: ASBackgroundConstant
    
    /// Initializes `ASConstant`
    /// - Parameters:
    ///   - axisMode: The axis mode of the component. The default value is `.bottom`
    ///   - size: The size of the content. The default value is `200`
    ///   - presentationMode: The mode of whether to expose the component when the isPresented value is false. The default value is `.minimize`
    ///   - header: The header status information.
    ///   - background: The component background status information.
    public init(axisMode: ASAxisMode = .bottom,
                size: CGFloat = 200,
                presentationMode: ASPresentationMode = .minimize,
                header: ASHeaderConstant = .init(),
                background: ASBackgroundConstant = .init()) {
        self.axisMode = axisMode
        self.size = size
        self.presentationMode = presentationMode
        self.header = header
        self.background = background
    }
}
