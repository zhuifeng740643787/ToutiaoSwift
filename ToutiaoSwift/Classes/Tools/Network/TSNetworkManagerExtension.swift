//
// Created by 宫宜栋 on 2017/10/17.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import Foundation
import YYModel

// 用户信息
extension TSNetworkManager{

    // 根据 账号和密码 获取token
    func loadAccessToken(account: String, password: String, completion: @escaping (_ isSuccess: Bool) -> ()) {

        // 从bundle加载data
        let path = Bundle.main.path(forResource: "userAccount.json", ofType: nil)
        let data = NSData(contentsOfFile: path!)

        // 从bundle加载配置的 userAccount.json
        guard let dict = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [String: AnyObject]
                else {
            return
        }

        // 直接用字典设置 userAccount 的属性
        self.userAccount.yy_modelSet(with: dict ?? [:])

        // 加载用户信息
        self.loadUserInfo {
            (dict) in
            self.userAccount.yy_modelSet(with: dict)
            self.userAccount.saveAccount()

            // 用户信息加载完成在执行，首页数据加载完成回调
            completion(true)
        }

    }

    // 加载用户信息
    func loadUserInfo(completion: @escaping (_ json: [String: AnyObject]) -> ()) {
        guard  let uid = userAccount.uid else {
            return
        }

        let params = ["uid" : uid]
        tokenRequest(method: .GET, URLString: TSUserInfoUrlString, parameters: params as [String: AnyObject]) {
            (json, isSuccess) in
            // 完成回调
            completion(json as? [String: AnyObject] ?? [:])
        }
    }

}

// 首页
extension TSNetworkManager {

    /* 微博数据字典数组
     *
     * - since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
     * - max_id: 返回ID小于或等于max_id的微博，默认为0
     * - completion: 微博字典数组 / 是否成功
     */
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {

        // swift 中 Int可以转换成 AnyObject， 但 Int64 不行
        let params = [
            "since_id": "\(since_id)",
            "max_id": "\(max_id > 0 ? (max_id - 1) : 0)"
        ]

        tokenRequest(URLString: TSHomeUrlString, parameters: params as [String: AnyObject]) {
            (json, isSuccess) in
            // 从 json 中获取 statuses 字典数组, 如果as?失败，return nil
            let result = (json as AnyObject)["statuses"] as? [[String: AnyObject]]

            completion(result, isSuccess)

        }

    }


    // 未读微博数量
    func unReadCount(completion: @escaping (_ count: Int) -> ()) {
        guard let uid = userAccount.uid else {
            return
        }

        let params = ["uid": uid]

        tokenRequest(URLString: TSUserUnReadCountUrlString, parameters: params as [String: AnyObject]) {
            (json, isSuccess) in
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int

            completion(count ?? 0)
        }

    }
}












