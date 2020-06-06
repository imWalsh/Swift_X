//
//  Dictionary+Extension.swift
//
//
//  Created by Walsh on 2018/4/30.
//  Copyright © 2018年 Walsh. All rights reserved.
//

import Foundation

extension Dictionary
{
    /// 转为 json 字符串
    var jsonString: String {
        let invalidJson = "无效JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    /// 转为 query 字符串
    var toQueryString: String {
        return self.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&").urlEscaped
    }
}
