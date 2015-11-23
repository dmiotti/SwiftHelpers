//
//  SHKeyboardViewController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

import UIKit

public class SHKeyboardViewController: UIViewController {
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private var scrollableView: UIScrollView?

    public func registerKeyboardNotificationForScrollableView(view: UIScrollView) {
        scrollableView = view
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let scrollableView = scrollableView {
            let scrollViewRect = view.convertRect(scrollableView.frame, fromView: scrollableView.superview)
            
            if let rectValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let kbRect = view.convertRect(rectValue.CGRectValue(), fromView: nil)
                
                let hiddenScrollViewRect = CGRectIntersection(scrollViewRect, kbRect)
                if !CGRectIsNull(hiddenScrollViewRect) {
                    var contentInsets = scrollableView.contentInset
                    contentInsets.bottom = hiddenScrollViewRect.size.height
                    scrollableView.contentInset = contentInsets
                    scrollableView.scrollIndicatorInsets = contentInsets
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let scrollableView = scrollableView {
            var contentInsets = scrollableView.contentInset
            contentInsets.bottom = 0
            scrollableView.contentInset = contentInsets
            scrollableView.scrollIndicatorInsets = contentInsets
        }
    }

}
