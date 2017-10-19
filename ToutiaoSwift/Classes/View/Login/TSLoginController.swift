//
// Created by 宫宜栋 on 2017/10/16.
// Copyright (c) 2017 宫宜栋. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

fileprivate let loginMargin: CGFloat = 16
fileprivate let buttonHeight: CGFloat = 40.0

class TSLoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        title = "登录"
        navigationItem.leftBarButtonItem = UIBarButtonItem(ts_title: "关闭", target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(ts_title: "注册", target: self, action: #selector(register))

        setupUI()
    }

    // 私有控件
    fileprivate lazy var logoImageView: UIImageView = UIImageView(ts_imageName: "logo")
    fileprivate lazy var accountTextField: UITextField = UITextField(ts_placeholder: "18221750346")
    fileprivate lazy var carve01: UIView = {
        let carve = UIView()
        carve.backgroundColor = UIColor.lightGray
        return carve
    }()

    fileprivate lazy var passwordTextField: UITextField = UITextField(ts_placeholder: "111111")
    fileprivate lazy var carve02: UIView = {
       let carve = UIView()
        carve.backgroundColor = UIColor.lightGray
        return carve
    }()

    //登录按钮
    fileprivate lazy var loginButton: UIButton = UIButton(ts_title: "登录", normalBackColor: UIColor.orange, highBackColor: UIColor.ts_color(withHex: 0xB5751F), size: CGSize(width: UIScreen.ts_screenWidth() - (loginMargin * 2), height: buttonHeight))

}

// Target - Action
extension TSLoginController {

    // 登录
    @objc fileprivate func login() {
        TSNetworkManager.shared.loadAccessToken(account: accountTextField.text ?? "", password: passwordTextField.text ?? "") {
            (isSuccess) in
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            } else {
                // 发送登录成功通知
                NotificationCenter.default.post(name: NSNotification.Name(TSUserLoginSuccessNotification), object: nil)
                // 关闭窗口
                self.close()
            }

        }
    }

    // 注册
    @objc fileprivate func register() {
        print("注册事件")
    }

    // 关闭
    @objc fileprivate func close() {
        dismiss(animated: true, completion: nil)
    }

}

// 设置登录控制器界面
extension TSLoginController {

    fileprivate func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(accountTextField)
        view.addSubview(carve01)
        view.addSubview(passwordTextField)
        view.addSubview(carve02)
        view.addSubview(loginButton)


        // 绑定事件
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)

        // 设置autolayout
        logoImageView.snp.makeConstraints {
            (make) in
            make.top.equalTo(view).offset(loginMargin * 7)
            make.centerX.equalTo(view)
        }
        accountTextField.snp.makeConstraints {
            (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(loginMargin * 2)
            make.left.equalTo(view).offset(loginMargin)
            make.right.equalTo(view).offset(-loginMargin)
            make.height.equalTo(buttonHeight)
        }
        carve01.snp.makeConstraints {
            (make) in
            make.left.equalTo(accountTextField)
            make.right.equalTo(accountTextField)
            make.bottom.equalTo(accountTextField)
            make.height.equalTo(0.5)
        }
        passwordTextField.snp.makeConstraints {
            (make) in
            make.top.equalTo(accountTextField.snp.bottom).offset(2)
            make.left.equalTo(accountTextField)
            make.right.equalTo(accountTextField)
            make.height.equalTo(buttonHeight)
        }
        carve02.snp.makeConstraints {
            (make) in
            make.left.equalTo(carve01)
            make.right.equalTo(carve01)
            make.bottom.equalTo(passwordTextField)
            make.height.equalTo(carve01)
        }

        loginButton.snp.makeConstraints {
            (make) in
            make.top.equalTo(passwordTextField).offset(loginMargin * 2)
            make.left.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField)
            make.height.equalTo(buttonHeight)
        }


    }

}

























