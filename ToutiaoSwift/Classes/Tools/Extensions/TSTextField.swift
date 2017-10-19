//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

extension UITextField {

    // 占位文字 + 边框样式（Optional） + 是否是密文（Optional）
    convenience init(ts_placeholder: String, border: UITextBorderStyle = .none, isSecureText: Bool = false) {
        self.init()

        placeholder = ts_placeholder
        borderStyle = border
        clearButtonMode = .whileEditing
        isSecureTextEntry = isSecureText
    }

}
