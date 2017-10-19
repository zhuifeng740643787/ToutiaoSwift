//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {

    // 根据图片名称快速创建`ImageView`
    convenience init(ts_imageName: String) {
        self.init(image: UIImage.init(named: ts_imageName))
    }

}

// 隔离`SDWebImage`框架
extension UIImageView {

    // 隔离`SDWebImage`设置图像函数
    func ts_setImage(urlString: String?, placeholderImage: UIImage?, isAvatar: Bool = false) {
        guard let urlString = urlString,
            let url = URL(string: urlString)
            else {
            image = placeholderImage
            return
        }

        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) {
            [weak self] (image, _, _, _) in
            if isAvatar {
                self?.image = image?.ts_avatarImage(size: self?.bounds.size)
            } else {
                self?.image = image?.ts_rectImage(size: self?.bounds.size)
            }
        }
    }

}
