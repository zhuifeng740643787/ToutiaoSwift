//
// Created by 宫宜栋 on 2017/10/13.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import AFNetworking

enum TSHTTPMETHOD {
    case GET
    case POST
}

class TSNetworkManager: AFHTTPSessionManager {

    // 单例模式
    static let shared: TSNetworkManager = {
        // 实例化对象
        let instance = TSNetworkManager()

        // 设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
    }()

    //用户账户的懒加载属性
    lazy var userAccount = TSUserAccount()
    var userLogin: Bool {
        return userAccount.token != nil
    }

    // 带token的网络请求方法
    func tokenRequest(method: TSHTTPMETHOD = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {

        // 判断token是否为nil，为nil直接返回
        guard let token = userAccount.token else {
            //发送通知，提示用户登录
            print("没有token，需要重新登录")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TSUserShouldLoginNotification), object: nil)

            completion(nil, false)
            return
        }

        var parameters = parameters
        if parameters == nil {
            parameters = [String: AnyObject]()
        }

        parameters!["access_token"] = token as AnyObject

        // 发起请求
        request(method: .GET, URLString: URLString, parameters: parameters, completion: completion)

    }

    // 封装AFN的GET / POST请求
    func request(method: TSHTTPMETHOD = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        // 成功回调
        let success = {
            (task: URLSessionDataTask, json: Any?) -> () in
            completion(json, true)
        }
        //失败回调
        let failure = {
            (task: URLSessionDataTask?, error: Error) -> () in
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token 过期了")

                //发送通知，提示用户再次登录
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: TSUserShouldLoginNotification), object: "bad token")
            }

            print("网络请求失败 \(error)")
            completion(nil, false)
        }

        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }

    }


}





























