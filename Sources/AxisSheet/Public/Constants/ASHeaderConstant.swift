//
//  ASHeaderConstant.swift
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

/// The header status information.
public struct ASHeaderConstant: Equatable {
    
    /// The size of the header.
    public var size: CGFloat
    
    /// The short axis size of the handle icon.
    public var shortAxis: CGFloat
    
    /// The long axis size of the handle icon.
    public var longAxis: CGFloat
    
    /// The round value of both corners.
    public var cornerRadius: CGFloat
    
    /// The color of the handle icon.
    public var color: Color
    
    /// The background color of the header.
    public var backgroundColor: Color
    
    
    /// Initializes `ASHeaderConstant`
    /// - Parameters:
    ///   - size: The size of the header. The default value is `42`
    ///   - shortAxis: The short axis size of the handle icon. The default value is `4`
    ///   - longAxis: The long axis size of the handle icon. The default value is `36`
    ///   - cornerRadius: The round value of both corners. The default value is `21`
    ///   - color: The color of the handle icon. The default value is `.accentColor`
    ///   - backgroundColor: The background color of the header. The default value is `.black.opacity(0.8)`
    public init(size: CGFloat = 42,
                shortAxis: CGFloat = 4,
                longAxis: CGFloat = 36,
                cornerRadius: CGFloat = 21,
                color: Color = .accentColor,
                backgroundColor: Color = .black.opacity(0.8)) {
        self.size = size
        self.shortAxis = shortAxis
        self.longAxis = longAxis
        self.cornerRadius = cornerRadius
        self.color = color
        self.backgroundColor = backgroundColor
    }
}
