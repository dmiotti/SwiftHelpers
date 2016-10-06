//
//  UITextFieldExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/03/2015.
//  Copyright (c) 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UITextField {
    public func selectTextAtRange(_ range: NSRange) {
        if let start = position(from: beginningOfDocument, offset: range.location) {
            if let end = position(from: start, offset: range.length) {
                selectedTextRange = textRange(from: start, to: end)
            }
        }
    }
}

#endif
