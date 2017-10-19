//
// Created by 宫宜栋 on 2017/10/17.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

class TSStatusViewModel: CustomStringConvertible {

    var status = TSStatus()

    // 会员图标
    var memberIcon: UIImage?
    // 认证图标（-1:未认证  0:认证用户 2,3,5:企业认证 220:达人）
    var vipIcon: UIImage?

    // 转发
    var retweetString: String?
    // 评论
    var commentString: String?
    // 赞
    var likeString: String?
    // 配图视图大小
    var pictureViewSize: CGSize?

    init(model: TSStatus) {
        self.status = model

        // 会员等级
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }

        // 认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
            break
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
            break
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
            break
        default:
            break
        }

        // 测试数量超过10000的情况
//        model.reposts_count = Int(arc4random_uniform(100000))
        // 转发、评论、赞
        retweetString = countString(count: model.reposts_count, defaultString: "转发")
        commentString = countString(count: model.comments_count, defaultString: "评论")
        likeString = countString(count: model.attitudes_count, defaultString: "赞")

        // 自定义配图视图的尺寸
        pictureViewSize = calculatePictureViewSize(count: model.pic_urls?.count)
    }

    var description: String {
        return status.description
    }

    // 计算指定配图数量对应的配图视图的大小
    fileprivate func calculatePictureViewSize(count: Int?) -> CGSize {

        if(count == 0 || count == nil) {
            return CGSize()
        }

        // 计算配图视图高度
        // 根据count计算行数1-9
        let row = (count! - 1) / 3 + 1
        // 根据行数算高度
        var height = TSStatusPictureViewOuterMargin
        height += CGFloat(row) * TSStatusPictureItemWidth
        height += CGFloat(row - 1) * TSStatusPictureViewInnerMargin

        return CGSize(width: TSStatusPictureViewWidth, height: height)
    }

    /*
     * 数量的自定义显示
     * - 如果 == 0     显示默认标题
     * - 如果 >= 10000 显示 x.xx 万
     * - 如果 < 10000  显示实际数字
     */
    fileprivate func countString(count: Int, defaultString: String) -> String {

        if count == 0 {
            return  defaultString
        }

        if count < 10000 {
            return count.description
        }

        return String(format: "%0.2f 万", CGFloat(count) / 10000)
    }

}





















