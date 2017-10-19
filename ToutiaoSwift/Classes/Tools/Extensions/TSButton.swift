//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

// 获取验证码按钮
class TSButton: UIButton {

    fileprivate var ts_timer: Timer?
    fileprivate var ts_remindTime: NSInteger?

    func timeDown(time: NSInteger) {

        isEnabled = false

        if #available(iOS 10.0, *) {
            ts_timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
                (timer) in
                self.timeFire()
            })
        } else {
            // iOS 10.0 之前版本调用
            ts_timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFire), userInfo: nil, repeats: true)
        }

    }

    @objc fileprivate func timeFire() {
        if ts_remindTime! > 1 {
            ts_remindTime! -= 1

            setTitle("\(ts_remindTime!)s后重新获取", for: .disabled)
            print("\(ts_remindTime!)s后重新获取")
        } else {
            isEnabled = true
            ts_timer?.invalidate()
            ts_timer = nil
            setTitle("获取验证码", for: .normal)
        }
    }
}

// 文字在左 图片在右的 Button
class TSTitleButton: UIButton {

    // 重载构造函数, title 如果是nil则显示首页，如果不是nil则显示title和箭头
    init(title: String?) {
        super.init(frame: CGRect())

        if title == nil {
            setTitle("首页", for: .normal)
        } else {
            setTitle(title! + " ", for: .normal)
            setImage(UIImage(named: "nav_arrow_down"), for: .normal)
            setImage(UIImage(named: "nav_arrow_up"), for: .selected)
        }

        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)

        // 设置大小
        sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()

        // 判断label和imageView是否同时存在
        guard let titleLabel = titleLabel,
              let imageView = imageView
                else {
            return
        }

        // 将titleLabel的x向左移动imageView的width，值得注意的是，这里我们需要将width/2
        titleEdgeInsets = UIEdgeInsetsMake(0, -imageView.bounds.width, 0, imageView.bounds.width)
        // 将imageView的x向右移动titleLabel的width，值得注意的是，我们需要将width/2
        imageEdgeInsets = UIEdgeInsetsMake(0, titleLabel.bounds.width, 0, -titleLabel.bounds.width)

        /********** 下面这种做法不推荐 **********/
        // 会有问题
//        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
//        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)

    }
}

extension UIButton {

    // 图片 + 背景图片
    convenience init(ts_imageName: String, ts_backImageName: String?) {
        self.init()

        setImage(UIImage(named: ts_imageName), for: .normal)
        setImage(UIImage(named: ts_imageName + "_highlighted"), for: .highlighted)

        if let backImageName = ts_backImageName {
            setBackgroundImage(UIImage(named: backImageName), for: .normal)
            setBackgroundImage(UIImage(named: backImageName + "_highlighted"), for: .highlighted)
        }

        // 根据背景图片大小调整尺寸
        sizeToFit()
    }

    // 标题 + 字体颜色
    convenience init(ts_title: String, fontSize: CGFloat = 16, normalColor: UIColor, highlightedColor: UIColor) {
        self.init()

        setTitle(ts_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(normalColor, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)

        // 注意，这里不写sizeToFit() 那么Button就显示不出来

        sizeToFit()
    }

    // 标题 + 文字颜色 + 背景图片
    convenience init(ts_title: String, color: UIColor, backImageName: String) {
        self.init()

        setTitle(ts_title, for: .normal)
        setTitleColor(color, for: .normal)

        setBackgroundImage(UIImage(named: backImageName), for: .normal)

        sizeToFit()
    }


    // 标题 + 字号 + 文字颜色 + 图片 + 背景图片
    // - titleEdge: 图片与文字间距
    convenience init(ts_title: String, fontSize: CGFloat, color: UIColor, imageName: String, backImageName: String, titleEdge: CGFloat) {
        self.init()

        setTitle(ts_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitleColor(color, for: .normal)
        setImage(UIImage(named: imageName), for: .normal)
        setBackgroundImage(UIImage(named: backImageName), for: .normal)

        titleEdgeInsets = UIEdgeInsetsMake(0, titleEdge, 0, -titleEdge)
        sizeToFit()
    }


    // 标题 + 字号 + 背景色 + 高亮背景色
    convenience init(ts_title: String, fontSize: CGFloat = 16, normalBackColor: UIColor, highBackColor: UIColor, size: CGSize) {
        self.init()

        setTitle(ts_title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)

        let normalImage = UIImage(ts_color: normalBackColor, size: CGSize(width: size.width, height: size.height))
        let highImage = UIImage(ts_color: highBackColor, size: CGSize(width: size.width, height: size.height))

        setBackgroundImage(normalImage, for: .normal)
        setBackgroundImage(highImage, for: .highlighted)

        layer.cornerRadius = 3
        clipsToBounds = true

        sizeToFit()
    }

}

// UIButton的扩展方法
extension UIButton {

    // 通过 颜色+尺寸 创建图片
    fileprivate func createImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
