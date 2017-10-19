//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    // 标题 + Target + Action
    convenience init(ts_title: String, fontSize: CGFloat = 16, target: Any?, action: Selector, isBack: Bool = false) {

        let btn = UIButton(ts_title: ts_title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)

        // 是否为返回按钮， 是的话就加上箭头"icon"
        if isBack {
            let imageName = "nav_back"
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }

        btn.addTarget(target, action: action, for: .touchUpInside)

        // self.init 实例化UIBarButtonItem
        self.init(customView: btn)
    }

}
