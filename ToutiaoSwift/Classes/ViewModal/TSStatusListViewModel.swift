//
// Created by 宫宜栋 on 2017/10/17.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import Foundation
import YYModel

// 上拉刷新的最大次数
fileprivate let maxPullUpTryTimes = 3

// 微博数据列表视图模型
class TSStatusListViewModel {

    // 微博视图模型的懒加载
    lazy var statusList = [TSStatusViewModel]()

    // 上拉刷新错误次数
    fileprivate var pullUpErrorTimes = 0

    // 加载微博数据字典数组
    func loadStatus(pullUp: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {

        if pullUp && pullUpErrorTimes > maxPullUpTryTimes {
            completion(true, false)
            print("超出3次，不再走网络请求方法")
            return
        }

        // 取出微博中已经加载的第一条微博（最新的一条微博）的 since_id 进行比较，对下拉刷新做处理
        let since_id = pullUp ? 0 : (statusList.first?.status.id ?? 0)
        // 上拉刷新，去除数组的最后一条微博id
        let max_id = !pullUp ? 0 : (statusList.last?.status.id ?? 0)

        TSNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) {
            (list, isSuccess) in

            // 如果网络请求失败，直接执行完成回调
            if !isSuccess {
                completion(false, false)
            }

            /*
             * 遍历字典数组，
             * - 字典 -> 模型
             * - 模型 -> 视图模型
             * 将视图模型添加到数组
             */
            var arrayM = [TSStatusViewModel]()
            for dict in list ?? [] {
                // 创建微博模型
                let status = TSStatus()
                // 字典转模型
                status.yy_modelSet(with: dict)
                // 使用TSStatus创建TSStatusViewModel 模型转视图模型
                let viewModel = TSStatusViewModel(model: status)
                //添加到数组
                arrayM.append(viewModel)
            }

            print("刷新到 \(arrayM.count) 条数据 \(arrayM)")

            // 拼接数据
            if pullUp {
                // 上拉刷新结束后，将数据拼接在数组的末尾
                self.statusList += arrayM
            } else {
                // 下拉刷新结束后，将数组拼接在数组的最前面
                self.statusList = arrayM + self.statusList
            }

            if pullUp && arrayM.count == 0 {
                self.pullUpErrorTimes += 1
                print("这是第 \(self.pullUpErrorTimes) 次加载到0条数据")
                completion(isSuccess, false)
            } else  {
                completion(isSuccess, true)
            }



        }


    }


}
