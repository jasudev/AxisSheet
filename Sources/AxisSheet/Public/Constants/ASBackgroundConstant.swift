//
//  ASBackgroundConstant.swift
//  AxisSheet
//
//  Created by jasu on 2022/02/15.
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

/// The component background status information.
public struct ASBackgroundConstant: Equatable {
    
    /// The translucent background color of the component.
    public var color: Color
    
    /// Disable the background.
    public var disabled: Bool
    
    /// Initializes `ASBackgroundConstant`
    /// - Parameters:
    ///   - color: The translucent background color of the component. The default value is `.black.opacity(0.3)`
    ///   - disabled: Disable the background. The default value is `false`
    public init(color: Color = .black.opacity(0.3), disabled: Bool = false) {
        self.color = color
        self.disabled = disabled
    }
}

