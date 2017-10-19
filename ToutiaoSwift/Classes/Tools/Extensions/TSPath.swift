//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

extension String {

    // DocumentDirectory 路径
    static func ts_appendDocumentDirectory(fileName: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (path as NSString).appendingPathComponent(fileName)
    }

    // Caches 路径
    static func ts_appendCachesDirectory(fileName: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        return (path as NSString).appendingPathComponent(fileName)
    }

    // Tmp 路径
    static func ts_appendTmpDirectory(fileName: String) -> String {
        let path = NSTemporaryDirectory()
        return (path as NSString).appendingPathComponent(fileName)
    }

}
