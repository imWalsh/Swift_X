//  Data+GIF.swift
//
//
//  Created by Walsh on 2018/4/22.
//  Copyright © 2018年 Walsh. All rights reserved.
//

import Foundation


private struct ImageHeaderData {
    static var PNG: [UInt8] = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
    static var JPEG_SOI: [UInt8] = [0xFF, 0xD8]
    static var JPEG_IF: [UInt8] = [0xFF]
    static var GIF: [UInt8] = [0x47, 0x49, 0x46]
}

extension NSData {
    func isGif() -> Bool {
        var buffer = [UInt8](repeating: 0, count: 8)
        self.getBytes(&buffer, length: 8)
        /// 判断文件头标识
        if buffer[0] == ImageHeaderData.GIF[0]
        && buffer[1] == ImageHeaderData.GIF[1]
        && buffer[2] == ImageHeaderData.GIF[2]
        {
            return true
        }
        
        return false
    }
}
