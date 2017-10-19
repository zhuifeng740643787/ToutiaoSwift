//
// Created by 宫宜栋 on 2017/10/17.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import Foundation
import UIKit

// 访客视图
class TSVisitorView: UIView {

    // 注册按钮
    lazy var registerButton: UIButton = UIButton(ts_title: "注册", color: .orange, backImageName: "common_button_white_disable")
    // 登录按钮
    lazy var loginButton: UIButton = UIButton(ts_title: "登录", color: .darkGray, backImageName: "common_button_white_disable")

    // 设置访客视图信息字典[imageName / message]
    var visitorInfo: [String: String]? {
        didSet {
            guard let imageName = visitorInfo?["imageName"],
                  let message = visitorInfo?["message"]
                    else {
                return
            }

            tipLabel.text = message
            if imageName == "" {
                startAnimation()
                return
            }
            iconImageView.image = UIImage(named: imageName)

            houseImageView.isHidden = true
            maskImageView.isHidden = true

        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }


    // 必要初始化器，一般出现在继承了NSCoding protocol的类，如UIView和UIViewController系列的类
    //当我们在子类定义了指定初始化器(包括自定义和重写父类指定初始化器)，那么必须显示实现required init?(coder aDecoder: NSCoder)，而其他情况下则会隐式继承，我们可以不用理会。
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 旋转视图动画
    fileprivate func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15

        // 设置动画一直保持转动，如果iconImageView被释放，动画会被一起释放
        anim.isRemovedOnCompletion = false
        // 将动画添加到图层
        iconImageView.layer.add(anim, forKey: nil)
    }

    // - 私有控件
    // 图像视图
    fileprivate lazy var iconImageView: UIImageView = UIImageView(ts_imageName: "visitordiscover_feed_image_smallicon")
    // 遮罩视图
    fileprivate lazy var maskImageView: UIImageView = UIImageView(ts_imageName: "visitordiscover_feed_mask_smallicon")
    // 小房子
    fileprivate lazy var houseImageView: UIImageView = UIImageView(ts_imageName: "visitordiscover_feed_image_house")
    // 提示标签
    fileprivate lazy var tipLabel: UILabel = UILabel(ts_title: "关注一些人，回这里看有什么惊喜，关注一些人，回这里看看有什么惊喜")

}

// 设置访客视图界面
extension TSVisitorView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.ts_color(withHex: 0xEDEDED)
        addSubview(iconImageView)
        addSubview(maskImageView)
        addSubview(houseImageView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)

        tipLabel.textAlignment = .center

        // 取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        /*
         * 利用原生自动布局代码进行自动布局
         * - 自动布局实质
         *   firstItem.firstAttribute {==, >=, <=} secondItem.secondAttribute * multiplier + constant
         */
        let margin: CGFloat = 20.0

        // 图像视图
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))

        // 小房子
        addConstraint(NSLayoutConstraint(item: houseImageView, attribute: .centerX, relatedBy: .equal, toItem: iconImageView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseImageView, attribute: .centerY, relatedBy: .equal, toItem: iconImageView, attribute: .centerY, multiplier: 1.0, constant: 0))

        // 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: iconImageView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .top, relatedBy: .equal, toItem: iconImageView, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 236))

        // 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: tipLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))

        // 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: tipLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: registerButton, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: registerButton, attribute: .width, multiplier: 1.0, constant: 0))


        // 遮罩视图布局，采用 VFL 布局
        /*
         VFL 可视化语言
         多用于连续参照关系,如遇到居中对其,通常多使用参照
         - `H`水平方向
         - `V`竖直方向
         - `|`边界
         - `[]`包含控件的名称字符串,对应关系在`views`字典中定义
         - `()`定义控件的宽/高,可以在`metrics`中指定
         */
        /*
         views: 定义 VFL 中控件名称和实际名称的映射关系
         metrics: 定义 VFL 中 () 内指定的常数映射关系,防止在代码中出现魔法数字
         */
        let viewDict: [String: Any] = ["maskImageView": maskImageView, "registerButton": registerButton]
        let metrics = ["spacing": -35]
        
//        addConstraint(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskImageView]-0-|", options: [], metrics: nil, views: viewDict))
//        addConstraint(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskImageView]-(spacing)-[registerButton]", options: [], metrics: metrics, views: viewDict))

        addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[maskImageView]-0-|",
                options: [],
                metrics: nil,
                views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[maskImageView]-(spacing)-[registerButton]",
                options: [],
                metrics: metrics,
                views: viewDict))


    }


}














