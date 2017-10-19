//
// Created by 宫宜栋 on 2017/10/13.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit 


extension UIScreen {

    // 屏幕的宽度
    class func ts_screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }

    //屏幕的高度
    class func ts_screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    //屏幕宽高比
    class func ts_scale() -> CGFloat {
        return CGFloat(UIScreen.ts_screenWidth()) / CGFloat(UIScreen.ts_screenHeight())
    }

}
