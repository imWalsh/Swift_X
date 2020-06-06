
//
//  Data+Extension.swift
//
//
//  Created by Walsh on 2018/4/22.
//  Copyright © 2018年 Walsh. All rights reserved.
//

import Foundation

public extension Data {
    /// 解析成 json
    func parseJsonData() -> Any? {
        do {
            let jsonValue = try JSONSerialization.jsonObject(with: self, options: [.mutableLeaves, .mutableContainers])
            return jsonValue
        }
        catch {
            return nil
        }
    }
    /// 转换成 16 进制字符串
    func hexedString() -> String {
        let string = self.map{ String($0, radix:16) }.joined()
        return string
    }
}
