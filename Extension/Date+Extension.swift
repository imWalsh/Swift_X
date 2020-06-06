//
//  Date+Extension.swift
//
//
//  Created by Walsh on 2018/4/25.
//  Copyright © 2018年 Walsh. All rights reserved.
//

import UIKit

public extension Date {
    
    /// 傳入13位時間戳
    init(timestamp: Double) {
        let timeInterval = TimeInterval(timestamp / 1000)
        self.init(timeIntervalSince1970: timeInterval)
    }
    /// 返回Date 13位時間戳
    var timeStamp: TimeInterval {
        return ceil(TimeInterval(self.timeIntervalSince1970 * 1000))
    }
    
    /// 两Date相差天数
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    /// 两Date是否为同一天
    func isSameDay(date: Date) -> Bool {
        let calender = Calendar.current
        return calender.isDate(self, inSameDayAs:date)
    }
    /// 两Date相差秒数
    func interval(to date: Date) -> TimeInterval {
        let difference = fabs(self.timeIntervalSince(date))
        return difference
    }
    
    func toString(format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(for: self)
    }
}
