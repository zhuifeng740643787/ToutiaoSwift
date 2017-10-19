//
// Created by 宫宜栋 on 2017/10/18.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import SnapKit

class TSHomeCellTopView: UIView {

    var viewModel: TSStatusViewModel? {
        didSet {
            avatarImageView.ts_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
            nameLabel.text = viewModel?.status.user?.screen_name
            memberIconView.image = viewModel?.memberIcon?.ts_rectImage(size: CGSize(width: 17, height: 17))
            vipIconImageView.image = viewModel?.vipIcon
        }
    }

    // 私有控件
    // 分隔线
    fileprivate lazy var carveView: UIView = {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.ts_screenWidth(), height: 8))
        view.backgroundColor = UIColor.ts_color(withHex: 0xF2F2F2)

        return view
    }()
    // 头像
    fileprivate lazy var avatarImageView: UIImageView = UIImageView(ts_imageName: "avatar_default_big")
    // 姓名
    fileprivate lazy var nameLabel: UILabel = UILabel(ts_title: "吴彦祖", fontSize: 14, color: UIColor.ts_color(withHex: 0xFC3E00))
    // 会员
    fileprivate lazy var memberIconView: UIImageView = UIImageView(ts_imageName: "common_icon_membership_level1")
    // 时间
    fileprivate lazy var timeLabel: UILabel = UILabel(ts_title: "现在", fontSize: 11, color: UIColor.ts_color(withHex: 0xFF6c00))
    // 来源
    fileprivate lazy var sourceLabel: UILabel = UILabel(ts_spaceText: "来源", fontSize: 11, color: UIColor.ts_color(withHex: 0x828282))
    // 认证
    fileprivate lazy var vipIconImageView: UIImageView = UIImageView(ts_imageName: "avatar_vip")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TSHomeCellTopView {

    fileprivate func setupUI() {
        addSubview(carveView)
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(vipIconImageView)

        // 设置autolayout约束
        avatarImageView.snp.makeConstraints {
            (make) in
            make.top.equalTo(carveView.snp.bottom).offset(margin)
            make.left.equalTo(self).offset(12)
            make.width.equalTo(AvatarImageViewWidth)
            make.height.equalTo(AvatarImageViewWidth)
        }
        nameLabel.snp.makeConstraints {
            (make) in
            make.top.equalTo(avatarImageView).offset(4)
            make.left.equalTo(avatarImageView.snp.right).offset(margin - 4)
        }
        memberIconView.snp.makeConstraints {
            (make) in
            make.left.equalTo(nameLabel.snp.right).offset(margin / 2)
            make.centerY.equalTo(nameLabel)
        }
        timeLabel.snp.makeConstraints {
            (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(avatarImageView)
        }
        sourceLabel.snp.makeConstraints {
            (make) in
            make.left.equalTo(timeLabel.snp.right).offset(margin / 2)
            make.centerY.equalTo(timeLabel)
        }
        vipIconImageView.snp.makeConstraints {
            (make) in
            make.centerX.equalTo(avatarImageView.snp.right).offset(-4)
            make.centerY.equalTo(avatarImageView.snp.bottom).offset(-4)
        }

    }
}
