//
// Created by 宫宜栋 on 2017/10/17.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

extension UILabel {

    // 标题 + 字体 + 字体颜色
    convenience init(ts_title: String, fontSize: CGFloat = 14, color: UIColor = UIColor.darkGray) {

        self.init()
        text = ts_title
        font = UIFont.systemFont(ofSize: fontSize)
        textColor = color
        numberOfLines = 0
    }

    // 可更改行间距的Label
    convenience init(ts_spaceText: String, fontSize: CGFloat = 16, color: UIColor = .darkGray, lineSpace: CGFloat = 6) {

        self.init()
        attributedText = getAttributeStringWithString(string: ts_spaceText, lineSpace: lineSpace)
        font = UIFont.systemFont(ofSize: fontSize)
        textColor = color
        numberOfLines = 0
    }

}

// - 调整行间距
extension UILabel {

    // 通过文字获取带行间距的富文本
    fileprivate func getAttributeStringWithString(string: String, lineSpace: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        // 通过富文本设置行间距
        let paragraphStyle = NSMutableParagraphStyle()
        // 调整行间距
        paragraphStyle.lineSpacing = lineSpace

        let rang = NSMakeRange(0, CFStringGetLength(string as CFString))
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: rang)

        return attributedString
    }

}
