//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

// ---- 全局通知定义
// 用户需要登录通知
let TSUserShouldLoginNotification: String = "TSUserShouldLoginNotification"
// 用户登录成功通知
let TSUserLoginSuccessNotification: String = "TSUserLoginSuccessNotification"


// ---- 常量
// 边距
let margin: CGFloat = 16


// ---- 接口
// 首页微博
let TSHomeUrlString: String = "https://api.weibo.com/2/statuses/home_timeline.json"
// 个人信息
let TSUserInfoUrlString: String = "https://api.weibo.com/2/users/show.json"
// 未读微博数量
let TSUserUnReadCountUrlString: String = "https://rm.api.weibo.com/2/remind/unread_count.json"

// ---- 微博配图视图常量
// 配图视图的外侧间距
let TSStatusPictureViewOuterMargin: CGFloat = 12
// 配图视图的内侧间距
let TSStatusPictureViewInnerMargin: CGFloat = 12
// 视图的宽度
let TSStatusPictureViewWidth: CGFloat = UIScreen.ts_screenWidth() - 2 * TSStatusPictureViewOuterMargin
// 每个Item默认宽度
let TSStatusPictureItemWidth: CGFloat = (TSStatusPictureViewWidth - 2 * TSStatusPictureViewInnerMargin) / 3






