//
// Created by 宫宜栋 on 2017/10/13.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit

class TSBaseViewController: UIViewController {

    // 设置访客视图信息字典
    var visitorInfoDictionary: [String: String]?

    // 用户不登录就不显示`tableView`
    var tableView: UITableView?

    // 刷新控件
    var refreshControl: UIRefreshControl?

    // 上拉刷新标识
    var isPullUp = false

    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.ts_screenWidth(), height: 64))

    // 自定义导航条, 以后设置导航条内容，统一使用`navItem`
    lazy var navItem = UINavigationItem()


    override func viewDidLoad() {
        super.viewDidLoad()

        // 取消自动缩进，当导航栏遇到`scrollView的时候，一般都要设置这个属性，默认是true，会使`scrollView`向下移动20个点
        automaticallyAdjustsScrollViewInsets = false

        setupUI()

        TSNetworkManager.shared.userLogin ? loadData() : ()
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: Notification.Name(rawValue: TSUserLoginSuccessNotification), object: nil)

    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: TSUserLoginSuccessNotification), object: nil)
    }


    // 加载数据，具体的由子类负责
    @objc func loadData(){
        // 如果子类不实现任何方法，默认关闭刷新控件
        refreshControl?.endRefreshing()
    }

    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    // 设置TableView
    // *  swift4版本，可能会被重载的类要不能放在 extension 中
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        //设置数据源和代理，子类可以直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        // 设置刷新控件
        refreshControl = UIRefreshControl()
        tableView?.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    
}

// - 注册 / 登录 点击事件
extension TSBaseViewController {

    // 登录成功
    @objc fileprivate func loginSuccess(n: Notification) {
        print("登录成功")

        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil

        // 在访问view的 getter 时，如果view == nil,会调用loadView() -> viewDidLoad()
        view = nil

        // 注销通知，因为重新执行viewDidLoad() 会再次注册通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: TSUserLoginSuccessNotification), object: nil)
    }

    // 登录
    @objc fileprivate func login() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: TSUserShouldLoginNotification), object: nil)
    }

    // 注册
    @objc fileprivate func register() {
        print("注册")
    }

    

}

//设置界面
extension TSBaseViewController {
    fileprivate func setupUI() {
        // 设置背景颜色
        view.backgroundColor = UIColor.ts_randomColor()

        // 设置导航条
        setupNavigationBar()

        TSNetworkManager.shared.userLogin ? setupTableView() : setupVisitorView()

    }

    

    // 设置访客视图
    func setupVisitorView() {
        let visitorView = TSVisitorView(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navigationBar)
        visitorView.visitorInfo = visitorInfoDictionary
        // 添加事件
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)

        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    }


    // 设置导航条
    fileprivate func setupNavigationBar() {
        //添加导航条
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]

        // 设置`navigationBar`的渲染颜色
        navigationBar.barTintColor = UIColor.ts_color(withHex: 0xF6F6F6)

        //设置导航栏title的颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]

        //设置系统leftBarButtonItem渲染颜色
        navigationBar.tintColor = UIColor.orange

    }


}

// - UITableViewDataSource, UITableViewDelegate
extension TSBaseViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
     基类只是实现方法，子类负责具体的实现
     子类的数据源方法不需要super
     返回UITableViewCell()只是为了没有语法错误
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let row = indexPath.row
        let section = tableView.numberOfSections - 1

        if row < 0 || section < 0 {
            return
        }

        let count = tableView.numberOfRows(inSection: section)

        if row == (count - 1) && !isPullUp {
            isPullUp = true
            loadData()
        }

    }
}
