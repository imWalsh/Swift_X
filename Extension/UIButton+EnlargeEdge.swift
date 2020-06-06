//
//  UIButton+EnlargeEdge.swift
//
//  Created by Walsh on 2017/9/8.
//  Copyright © 2017年 Walsh. All rights reserved.
//

import UIKit

fileprivate var topNameKey: UInt8 = 0
fileprivate var rightNameKey: UInt8 = 0
fileprivate var bottomNameKey: UInt8 = 0
fileprivate var leftNameKey: UInt8 = 0

extension UIButton {
    /// 不更改按钮 frame 情况下，扩大点击面积
    public func setEnlargeEdge(top _top: CGFloat, left _left: CGFloat, bottom _bottom: CGFloat, right _right: CGFloat) {
        objc_setAssociatedObject(self, &topNameKey, _top, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &leftNameKey, _left, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &bottomNameKey, _bottom, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &rightNameKey, _right, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    func enlargedRect() -> CGRect {
        let topEdge = objc_getAssociatedObject(self, &topNameKey) as? NSNumber;
        let rightEdge = objc_getAssociatedObject(self, &rightNameKey) as? NSNumber;
        let bottomEdge = objc_getAssociatedObject(self, &bottomNameKey) as? NSNumber;
        let leftEdge = objc_getAssociatedObject(self, &leftNameKey) as? NSNumber;
        if  (topEdge != nil) &&
            (rightEdge != nil) &&
            (bottomEdge != nil) &&
            (leftEdge != nil) &&
            self.isUserInteractionEnabled &&
            !self.isHidden
        {
            return CGRect(x: self.bounds.origin.x - CGFloat(leftEdge!.floatValue),
                          y: self.bounds.origin.y - CGFloat(topEdge!.floatValue),
                          width: self.bounds.size.width + CGFloat(leftEdge!.floatValue) + CGFloat(rightEdge!.floatValue),
                          height: self.bounds.size.height + CGFloat(topEdge!.floatValue) + CGFloat(bottomEdge!.floatValue));
        }
        else {
            return self.bounds;
        }
    }
    // 判断点击是否在扩大范围内
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = enlargedRect()
        if rect.equalTo(self.bounds) {
            return super.hitTest(point, with: event)
        }
        return rect.contains(point) ? self : nil;
    }
}
