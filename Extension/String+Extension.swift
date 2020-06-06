//
//  String+Extension.swift
//
//  Created by Walsh on 2017/9/8.
//  Copyright © 2017年 Walsh. All rights reserved.
//

extension String {
    /// 除去特殊字符 用作 URL 转义
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    }
    /// 转换成字典
    var parametersFromQueryString: [String : String] {
        if self.count == 0 { return [:] }
        if !self.contains("&") || !self.contains("=") { return [:] }
        
        let params = self.components(separatedBy: "&").map({
            $0.components(separatedBy: "=")
        }).reduce(into: [String:String]()) { dict, pair in
            if pair.count == 2 {
                dict[pair[0]] = pair[1]
            }
        }
        
        return params
    }
    
    /// 去掉前后空白
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    /// 返回前置第一个匹配索引
    func indexOf(_ string: String) -> Int? {
        guard let index = range(of: string, options: []) else { return nil }
        return self.distance(from: self.startIndex, to: index.lowerBound)
    }
    /// 返回后置第一个匹配索引
    func lastIndex(of string: String) -> Int? {
        guard let index = range(of: string, options: .backwards) else { return nil }
        return self.distance(from: self.startIndex, to: index.lowerBound)
    }
    
    /// 根据开始位置和长度截取字符串
    func subString(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    func parseJsonData() -> Any? {
        if self.isEmpty { return self }
        
        if let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)
        {
            let jsonValue = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves, JSONSerialization.ReadingOptions.mutableContainers])
            return jsonValue
        }
        
        return nil
    }
    
    func toCharArray() -> [UInt8] {
        if let data = self.data(using: .utf8) {
            return [UInt8](data)
        }
        return []
    }
}
