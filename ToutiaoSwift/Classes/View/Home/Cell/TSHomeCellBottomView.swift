//
// Created by 宫宜栋 on 2017/10/18.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import SnapKit

class TSHomeCellBottomView: UIView {

    var viewModel: TSStatusViewModel? {
        didSet {
            retweetedButton.setTitle(viewModel?.retweetString, for: .normal)
            commentButton.setTitle(viewModel?.commentString, for: .normal)
            likeButton.setTitle(viewModel?.likeString, for: .normal)
        }
    }


    // 私有控件
    // 转发
    fileprivate lazy var retweetedButton: UIButton = UIButton(ts_title: "转发", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_retweet", backImageName: "timeline_card_bottom_background", titleEdge: 5)
    // 评论
    fileprivate lazy var commentButton: UIButton = UIButton(ts_title: "评论", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_comment", backImageName: "timeline_card_bottom_background", titleEdge: 5)
    // 赞
    fileprivate lazy var likeButton: UIButton = UIButton(ts_title: "赞", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_unlike", backImageName: "timeline_card_bottom_background", titleEdge: 5)
    // 分割线1
    fileprivate lazy var sepView01: UIImageView = UIImageView(ts_imageName: "timeline_card_bottom_line_highlighted")
    // 分割线2
    fileprivate lazy var sepView02: UIImageView = UIImageView(ts_imageName: "timeline_card_bottom_line_highlighted")

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TSHomeCellBottomView {

    fileprivate func setupUI() {

        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        addSubview(retweetedButton)
        addSubview(commentButton)
        addSubview(likeButton)
        addSubview(sepView01)
        addSubview(sepView02)

        // 设置autolayout约束
        retweetedButton.snp.makeConstraints {
            (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.bottom.equalTo(self)
        }

        commentButton.snp.makeConstraints {
            (make) in
            make.top.equalTo(retweetedButton)
            make.left.equalTo(retweetedButton.snp.right)
            make.width.equalTo(retweetedButton)
            make.height.equalTo(retweetedButton)
        }

        likeButton.snp.makeConstraints {
            (make) in
            make.top.equalTo(retweetedButton)
            make.left.equalTo(commentButton.snp.right)
            make.right.equalTo(self)
            make.width.equalTo(retweetedButton)
            make.height.equalTo(retweetedButton)
        }
        sepView01.snp.makeConstraints {
            (make) in
            make.right.equalTo(retweetedButton)
            make.centerY.equalTo(retweetedButton)
        }
        sepView02.snp.makeConstraints {
            (make) in
            make.right.equalTo(commentButton)
            make.centerY.equalTo(commentButton)
        }

    }

}



























