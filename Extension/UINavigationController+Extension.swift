 //
//  UINavigationController+Extension.swift
//  
//
//  Created by Walsh on 2018/6/4.
//  Copyright © 2018年 Walsh. All rights reserved.
//

import UIKit

public extension UINavigationController
{
    /// 清除当前 controller 之前的栈
    func clearBackStack() {
        if self.viewControllers.count <= 1 { return }
        
        var controllers = self.viewControllers
        while controllers.count > 1 {
            controllers.remove(at: 0)
        }
        self.viewControllers = controllers
    }
}
