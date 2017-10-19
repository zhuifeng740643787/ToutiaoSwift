//
// Created by 宫宜栋 on 2017/10/18.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import SnapKit

class TSHomeCellPictureView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TSHomeCellPictureView {

    fileprivate func setupUI() {

        // 超出边界不显示
        clipsToBounds = true

        backgroundColor = UIColor.ts_randomColor()

        /*
          - cell 中所有的控件都是提前准备好
          - 设置的时候，根据数据决定是否显示
          - 不要动态创建控件
        */

        let count = 3
        let rect = CGRect(x: 0, y: TSStatusPictureViewOuterMargin, width: TSStatusPictureItemWidth, height: TSStatusPictureItemWidth)

        for i in 0..<count * count {

            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.red

            // 行 -> Y
            let row = CGFloat(i / count)
            // 列 -> X
            let col = CGFloat(i % count)

            let xOffset = col * (TSStatusPictureItemWidth + TSStatusPictureViewInnerMargin)
            let yOffset = row * (TSStatusPictureItemWidth + TSStatusPictureViewInnerMargin)

            imageView.frame = rect.offsetBy(dx: xOffset, dy: yOffset)

            addSubview(imageView)

        }

    }

}


























