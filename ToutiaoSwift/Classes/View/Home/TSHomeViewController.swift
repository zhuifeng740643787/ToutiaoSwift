//
// Created by 宫宜栋 on 2017/10/17.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import Foundation
import UIKit

fileprivate let TSHomeCellId = "TSHomeCellId"

class TSHomeViewController: TSBaseViewController {

    fileprivate lazy var listViewModel = TSStatusListViewModel()

    // 加载数据
    override func loadData() {
        listViewModel.loadStatus(pullUp: self.isPullUp) {
            (isSuccess, shouldRefresh) in

            self.refreshControl?.endRefreshing()
            self.isPullUp = false

            if shouldRefresh {
                self.tableView?.reloadData()
            }
        }
    }


    @objc fileprivate func showFriends() {
        TSNetworkManager.shared.userAccount.token = "aaa"

    }
    // 重写父类的方法
    override func setupTableView() {
        super.setupTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem(ts_title: "好友", target: self, action: #selector(showFriends))
        tableView?.register(TSHomeCell.classForCoder(), forCellReuseIdentifier: TSHomeCellId)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 400
        tableView?.separatorStyle = .none
        
    }

}

// - tableViewDataSource
extension TSHomeViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TSHomeCellId, for: indexPath) as! TSHomeCell

        let viewModel = listViewModel.statusList[indexPath.row]

        cell.viewModel = viewModel

        return cell
    }

}

// - 设置界面
extension TSHomeViewController {


    

    // 设置导航栏标题演示
    fileprivate func setupNavTitle() {
        let title = TSNetworkManager.shared.userAccount.screen_name
        let btn = TSTitleButton(title: title)
        navItem.titleView = btn
        btn.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }

    @objc fileprivate func clickTitleButton(btn: UIButton) {
        btn.isSelected = !btn.isSelected
    }

}































