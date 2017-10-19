//
// Created by 宫宜栋 on 2017/10/13.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import YYModel


fileprivate let fileName = "userAccount.json"

class TSUserAccount: NSObject {


    // Token
    var token: String?

    // 用户代号
    var uid: String?

    // 过期日期
    var expiresDate: Date?

    // Token的生命周期，单位是秒
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }

    // 用户昵称
    var screen_name: String?

    // 用户头像(大图：180x180)
    var avatar_large: String?

    override var description: String {
        return yy_modelDescription()
    }

    override init() {
        super.init()

        // 解析用户数据
        guard let path = String.ts_appendDocumentDirectory(fileName: fileName),
              let data = NSData(contentsOfFile: path),
              let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject]
                else {
            return
        }

        // 使用字典设置属性
        // 用户是否登录的关键代码
        yy_modelSet(with: dict ?? [:])

        // 模拟日期过期
//        expiresDate = Date(timeIntervalSinceNow: -3600 * 24 * 265 * 5)

        // 判断token是否过期
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("账户过期")
            // 清空token
            token = nil
            uid = nil
            // 删除文件
            try? FileManager.default.removeItem(atPath: path)
        }

    }

    /*
        数据存储方式
        - 1.偏好设置
        - 2.沙盒 - 归档 / `plist` / `json`
        - 3.数据库（`FMDB` / CoreData）
        - 4.钥匙串访问（存储小类型数据，存储时会自动加密，需要使用框架`SSKeyChain`）
    */
    func saveAccount() {
        // 1.模型转字典
        var dict = self.yy_modelToJSONObject() as? [String: AnyObject] ?? [:]
        // 删除expires_in值
        dict.removeValue(forKey: "expires_in")

        // 2.字典序列化data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
                let filePath = String.ts_appendDocumentDirectory(fileName: fileName)
                else {
            return
        }

        // 3.写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
    }


}



