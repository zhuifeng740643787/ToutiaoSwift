//
// Created by 宫宜栋 on 2017/10/18.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

class TSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isHidden = true
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true

            /*
             * 判断控制器的类型
             * - 如果是第一级页面，不显示leftBarButtonItem
             * - 如果是第二级页面以后才显示leftBarButtonItem
             */
            if let vc = viewController as? TSBaseViewController {
                var title = "返回"

                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }

                vc.navItem.leftBarButtonItem = UIBarButtonItem(ts_title: title, target: self, action: #selector(popToParent), isBack: true)

            }

        }

        super.pushViewController(viewController, animated: true)
    }

    @objc fileprivate func popToParent() {
        popViewController(animated: true)
    }

}
