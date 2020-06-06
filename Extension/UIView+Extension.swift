
//
//  UIView+Extension.swift
//
//  Created by Walsh on 2017/9/7.
//  Copyright © 2017年 Walsh. All rights reserved.
//

import UIKit
//import ObjectiveC

typealias tapGestureClosure = (_ gesture: UITapGestureRecognizer) -> Void

private var tapGestureKey: UInt8 = 0

extension UIView {
    
    //MARK:- property
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    public var maxX: CGFloat {
        get {
            return self.x + self.width
        }
    }
    
    public var maxY: CGFloat {
        get {
            return self.y + self.height
        }
    }
    
    public var tapGesture: tapGestureClosure? {
        get {
           return objc_getAssociatedObject(self, &tapGestureKey) as? tapGestureClosure
        }
        set {
            objc_setAssociatedObject(self, &tapGestureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    //MARK:- method
    
    /// 添加边框
    /// - Parameters:
    ///   - radius: 边框圆角半径
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    public func viewBorderRadius(radius: CGFloat, width: CGFloat = 0, color: UIColor = .clear)
    {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    /// 指定四个角中的某些为圆角
    /// - Parameters:
    ///   - corners:  topLeft, topRight, bottomLeft, bottomRight, allCorners
    ///   - radius: 圆角半径
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// 左右震动
    public func shake() {
        let shake = CAKeyframeAnimation(keyPath: "position.x")
        shake.values = [0, -6, 6, -6, 6, 0]
        shake.isAdditive = true
        shake.duration = 0.35
        self.layer.add(shake, forKey: "shake")
    }
    
    
    /// 截图快照
    /// - Returns: 生成的图片
    public func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    /// 移除所有子视图
    public func removeAllSubviews() {
        while self.subviews.count > 0 {
            let sub = self.subviews.last
            sub?.removeFromSuperview()
        }
    }
    
    /// 添加点击手势
    @discardableResult
    public func addTapGesture(_ callback: @escaping tapGestureClosure) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleGesture(gestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        self.tapGesture = callback
        return tap
    }
    
    @objc private func handleGesture(gestureRecognizer: UITapGestureRecognizer) {
        if tapGesture != nil
        {
            tapGesture!(gestureRecognizer)
        }
    }
}
