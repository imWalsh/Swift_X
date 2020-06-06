//
//  Array+Extension.swift
//  
//
//  Created by Walsh on 2018/4/25.
//  Copyright © 2018年 Walsh. All rights reserved.
//

import Foundation

public extension Array {
    /// 按条件分组
    /// - Parameters:
    ///   - groupClosure: 条件
    ///   - maxCount: 最大数
    /// - Returns: 分组后的二维数组
    func groupBy<G: Hashable>(_ groupClosure: (Element) -> G, maxCount: Int = 0) -> [[Element]] {
        var groups = [[Element]]()
        
        for element in self {
            let key = groupClosure(element)
            var active = Int()
            var isNewGroup = true
            var array = [Element]()
            
            for (index, group) in groups.enumerated() {
                let firstKey = groupClosure(group[0])
                if firstKey == key {
                    array = group
                    active = index
                    isNewGroup = false
                    break
                }
            }
            
            if maxCount != 0 {
                if array.count <= maxCount {
                    array.append(element)
                }
            }
            else {
                array.append(element)
            }
            
            if isNewGroup {
                groups.append(array)
            } else {
                groups.remove(at: active)
                groups.insert(array, at: active)
            }
        }
        
        return groups
    }
    
    /// 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
