//
//  SHUIScrollViewExtension.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Wopata. All rights reserved.
//

import UIKit

#if os(iOS)

extension UIScrollView {

    /**
     Scrolls to the bottom of the scrollview.
     - parameter animated: Whether the scroll should be animated or not
     */
    func scrollToBottom(animated animated: Bool) {
        var bottomContentOffset = contentOffset
        bottomContentOffset.y = contentSize.height - bounds.height + contentInset.bottom
        setContentOffset(bottomContentOffset, animated: animated)
    }

}

#endif
