//
// Created by 宫宜栋 on 2017/10/18.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import SnapKit

// 头像的宽度
let AvatarImageViewWidth: CGFloat = 35

class TSHomeCell: UITableViewCell {

    var viewModel: TSStatusViewModel? {
        didSet {
            topView.viewModel = viewModel
            contentLabel.text = viewModel?.status.text
            bottomView.viewModel = viewModel

            var height: CGFloat = 0
            height = viewModel?.pictureViewSize?.height ?? 0
            pictureView.snp.updateConstraints {
                (make) in
                make.height.equalTo(height)
            }
        }
    }

    // 私有控件
    // 顶部视图
    fileprivate lazy var topView: TSHomeCellTopView = TSHomeCellTopView()
    // 正文
    fileprivate lazy var contentLabel: UILabel = UILabel(ts_title: "正文", fontSize: 15, color: UIColor.darkGray)
    // 配图视图
    fileprivate lazy var pictureView: TSHomeCellPictureView = TSHomeCellPictureView()
    // 底部视图
    fileprivate lazy var bottomView: TSHomeCellBottomView = TSHomeCellBottomView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TSHomeCell {

    fileprivate func setupUI() {
        addSubview(topView)
        addSubview(contentLabel)
        addSubview(pictureView)
        addSubview(bottomView)

        // 设置autolayout 约束
        topView.snp.makeConstraints {
            (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(margin * 2 + AvatarImageViewWidth)
        }
        contentLabel.snp.makeConstraints {
            (make) in
            make.top.equalTo(topView.snp.bottom).offset(margin / 2)
            make.left.equalTo(self).offset(margin)
            make.right.equalTo(self).offset(-12)
        }
        pictureView.snp.makeConstraints {
            (make) in
            make.top.equalTo(contentLabel.snp.bottom)
            make.left.equalTo(contentLabel)
            make.right.equalTo(contentLabel)
            make.bottom.equalTo(bottomView.snp.top).offset(-12)
            make.height.equalTo(300)
        }

        bottomView.snp.makeConstraints {
            (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(44)
        }


    }


}












