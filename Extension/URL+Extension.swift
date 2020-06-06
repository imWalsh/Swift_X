 //
//  URL+Extension.swift
//  
//
//  Created by Walsh on 2018/6/4.
//  Copyright © 2018年 Walsh. All rights reserved.
//

import Foundation

extension URL {
    /// 找到某个字段下的 value
    /// - Parameter queryParamaterName: 字段名
    /// - Returns: 值
    public func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
