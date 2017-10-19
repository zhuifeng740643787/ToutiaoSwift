//
// Created by 宫宜栋 on 2017/10/13.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

extension UIColor {


    // 普通字体颜色
    open class var ts_textColor: UIColor {
        get {
            return UIColor.lightGray
        }
    }

    //标题字体颜色
    open class var ts_titleTextColor: UIColor {
        get {
            return UIColor.darkGray
        }
    }

    // 随机色
    class func ts_randomColor() -> UIColor {
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

    // 十六进制颜色
    class func ts_color(withHex: UInt32) -> UIColor {
        let r = ((CGFloat)((withHex & 0xFF0000) >> 16)) / 255.0
        let g = ((CGFloat)((withHex & 0xFF00) >> 8)) / 255.0
        let b = ((CGFloat)(withHex & 0xFF)) / 255.0

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }


    // 0~255 颜色
    class func ts_color(withRed: UInt8, withGreen: UInt8, withBlue: UInt8) -> UIColor {
        let r = CGFloat(withRed) / 255.0
        let g = CGFloat(withGreen) / 255.0
        let b = CGFloat(withBlue) / 255.0

        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

}
