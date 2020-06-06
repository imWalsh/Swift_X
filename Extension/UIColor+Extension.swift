//
//  Color+Extension.swift
//
//  Created by Walsh on 2017/9/7.
//  Copyright © 2017年 Walsh. All rights reserved.
//

import UIKit

public extension UIColor {
    /// 随机颜色
    class var random: UIColor {
        get {
            let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let green = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
//            let alpha = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
    /// 16进制
    convenience init(hex value: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((value & 0xFF00) >> 8) / 255.0,
                       blue: CGFloat(value & 0xFF) / 255.0,
                       alpha: alpha)
    }
    
    convenience init(a: CGFloat = 1.0, r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
