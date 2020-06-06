//
//  DispatchQueue+Once.swift
//
//
//  Created by Walsh on 2019/5/9.
//  Copyright © 2019年 Walsh. All rights reserved.

import Foundation

extension DispatchQueue {
    /// 仿 OC dispatch_once
    private static var _onceTracker = [String]()
    public class func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
