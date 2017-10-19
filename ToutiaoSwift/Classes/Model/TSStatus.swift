//
// Created by 宫宜栋 on 2017/10/17.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import YYModel

// 微博数据模型
class TSStatus: NSObject {

    // 微博ID
    var id: Int64 = 0
    //微博信息内容
    var text: String?

    // 用户属性信息
    var user: TSUser?

    // 转发数
    var reposts_count: Int = 0
    // 评论数
    var comments_count: Int = 0
    // 表态数
    var attitudes_count: Int = 0

    // 此处会崩溃😖
    // 微博配图模型数组
    var pic_urls: [TSStatusPicture]?
    override var description: String {
        return yy_modelDescription()
    }
}
