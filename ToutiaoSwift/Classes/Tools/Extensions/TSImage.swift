//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

extension UIImage {

    // 根据（颜色 + 尺寸） 快速创建图片
    convenience init?(ts_color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        ts_color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else {
            return nil
        }

        self.init(cgImage: cgImage)

    }

}

// 创建图像的自定义方法
extension UIImage {

    // 创建圆角图像
    func ts_avatarImage(size: CGSize?, backColor: UIColor = UIColor.white, lineColor: UIColor = UIColor.lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }

        let rect = CGRect(origin: CGPoint(), size: size!)
        // 1.图像的上下文-内存中开辟一个地址，跟屏幕无关
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        // 背景色填充
        backColor.setFill()
        UIRectFill(rect)

        // 实例化一个圆形的路径
        let path = UIBezierPath(ovalIn: rect)
        // 进行路径裁剪 - 后续的绘图，都会出现在圆形路径内部，外部的全部干掉
        path.addClip()

        // 2.绘图 drawInRect 就是在指定区域内拉伸屏幕
        draw(in: rect)

        // 3.绘制内切的圆形
        UIColor.darkGray.setStroke()
        path.lineWidth = 1
        path.stroke()

        // 4.取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()

        // 5.关闭上下文
        UIGraphicsEndImageContext()

        // 6.返回结果
        return result
    }

    // 创建矩形图像
    func ts_rectImage(size: CGSize?, backColor: UIColor = UIColor.white, lineColor: UIColor = UIColor.lightGray) -> UIImage? {
        var size = size
        if size == nil {
            size = self.size
        }

        let rect = CGRect(origin: CGPoint(), size: size!)

        // 1.图像的上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        // 背景填充
        backColor.setFill()
        UIRectFill(rect)

        // 2.绘制drawInRec 就是在指定区域内拉伸
        draw(in: rect)

        // 3.取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()

        // 4.关闭上下文
        UIGraphicsEndImageContext()

        // 5.返回结果
        return result
    }

}
