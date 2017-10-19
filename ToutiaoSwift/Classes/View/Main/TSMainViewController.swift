//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class TSMainViewController: UITabBarController {

    // 定时器
    fileprivate var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        setupComposeButton()
        setupTimer()

        // 新特性
        setupNewFeatureView()


        delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(login), name: NSNotification.Name(TSUserShouldLoginNotification), object: nil)

    }

    deinit {
        //销毁定时器
        timer?.invalidate()

        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: TSUserShouldLoginNotification), object: nil)
    }


    // 设置支持横向之后，之前的控制器及子控制器都会遵循这个方向，因此写在TSMainViewController里面
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // 私有控件

    // 撰写按钮
    fileprivate lazy var composeButton = UIButton(ts_imageName: "tabbar_compose_icon_add", ts_backImageName: "tabbar_compose_button")

}

// Target Action
extension TSMainViewController {

    // - 登录监听方法
    @objc fileprivate func login(n: Notification) {
        print("用户登录通知 \(n)")

        var when = DispatchTime.now()
        if n.object != nil {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "登录超时，请重新登录")

            //修改延迟时间
            when = DispatchTime.now() + 2
        }

        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)
            let nav = UINavigationController(rootViewController: TSLoginController())
            self.present(nav, animated: true, completion: nil)
        }
    }

    // @objc 允许这个函数在运行时通过 OC 消息的消息机制被调用
    @objc fileprivate func composeStatus() {
        print("点击加号按钮")
        let vc = UIViewController()
        let nav = UINavigationController(rootViewController: vc)

        vc.view.backgroundColor = UIColor.ts_randomColor()
        present(nav, animated: true, completion: nil)
    }
}

// - 新特性
extension TSMainViewController {

    fileprivate func setupNewFeatureView() {
        //如果没有用户登录，则不显示新特性界面，直接返回
        if !TSNetworkManager.shared.userLogin {
            return
        }

    }


    // 计算型属性，不占用存储空间
    fileprivate var isNewVersion: Bool {
        //获取当前版本号
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

        // 拼接保存到沙盒的路径
        let path = String.ts_appendDocumentDirectory(fileName: "version") ?? ""
        let savedVersion = (try? String(contentsOfFile: path)) ?? ""

        // 将当前版本保存到沙盒路径下
        try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)

        // 比较两个版本是否相同
        return currentVersion != savedVersion
    }

}

// - UITabBarControllerDelegate
extension UITabBarController: UITabBarControllerDelegate {

    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 获取当前控制器在数组中的索引
        let index = childViewControllers.index(of: viewController)
        if selectedIndex == 0 && index == selectedIndex {

            // 获取到当前控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! TSHomeViewController

            // 滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)

            // 增加延迟，目的是为了保证表格先滚动到顶部，然后再刷新，这样显示不会有问题
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                vc.loadData()
            })

            // 清除 tabBarItem 的 badgeNumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0

        }

        return !viewController.isMember(of: UIViewController.classForCoder())
    }

}

// - 定时器相关方法
extension TSMainViewController {

    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60 * 10, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }

    // 定时器触发方法
    @objc fileprivate func updateTimer() {

        if !TSNetworkManager.shared.userLogin {
            return
        }

        TSNetworkManager.shared.unReadCount {
            (count) in
            print("检测到 \(count) 条微博")
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            UIApplication.shared.applicationIconBadgeNumber = count
        }

    }

}

// extension 类似于 OC 中的分类，在 Swift 中还可以用来切分代码块，可以把功能相近的函数，放在一个extension中
extension TSMainViewController {

    // 设置撰写按钮
    fileprivate func setupComposeButton() {

        tabBar.addSubview(composeButton)

        // 设置按钮的位置
        let count = CGFloat(childViewControllers.count)
        // 减一是为了使按钮变宽，覆盖住系统的容错点
        let w = tabBar.bounds.size.width / count - 1
        composeButton.frame = tabBar.bounds.insetBy(dx: w * 2, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)

    }

    // 设置所有子控制器
    fileprivate func setupChildControllers() {

        // 获取沙盒 json 路径
        let jsonPath = String.ts_appendDocumentDirectory(fileName: "main.json")
        // 加载data
        var data = NSData(contentsOfFile: jsonPath!)

        // 如果data没有内容，说明沙盒没有内容
        if data == nil {
            // 从 bundle 加载 data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }

        // 从bundle加载配置的json
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]]
                else {
            return
        }

        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }

    /*
     * 使用字典创建一个子控制器
     * - 信息字典[className, title, imageName, visitorInfo]
     */
    fileprivate func controller(dict: [String: AnyObject]) -> UIViewController {
        
        // 1. 获取字典内容
        guard let className = dict["className"] as? String,
              let title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String,
              let cls  = NSClassFromString(Bundle.main.namespace + "." + className) as? TSBaseViewController.Type,
              let visitorDict = dict["visitorInfo"] as? [String: String]
                else {
            return UIViewController()
        }


        print("设置tabar控制器...")
        // 2. 创建视图控制器
        let vc = cls.init()
        vc.title = title
        vc.visitorInfoDictionary = visitorDict

        // 3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)

        // 4. 设置tabBar标题颜色
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .selected)
        // 5. 设置tabBar标题字体大小，系统默认是12
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: .normal)


        let nav = TSNavigationController(rootViewController: vc)
        return nav
    }

}

