//
//  MeSettingViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MeSettingViewController: UIViewController {
    
    
    
    var tabbar:RootViewController?
    
    @IBOutlet weak var layoutTop: NSLayoutConstraint!
    
    @IBOutlet weak var labWx: UILabel!
    
    @IBOutlet weak var labQQ: UILabel!
    
    @IBOutlet weak var labSina: UILabel!
    @IBOutlet weak var viewVersionShow: UIView!
    @IBOutlet weak var labPhoneNumber: UILabel!
    @IBOutlet weak var labCaches: UILabel!
    @IBOutlet weak var labVersion: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        self.title = "个人设置"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        
        // 初始化数据
        let infoDictionary = Bundle.main.infoDictionary!
//        let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
        let majorVersion:String = infoDictionary["CFBundleShortVersionString"] as! String//主程序版本号
        self.labVersion.text =  "版本V" + majorVersion
        
        self.labCaches.text = String.init(format: "%.2fMB", fileSizeOfCache())
        
        let model:ModelUser = CommonTool.unarhiveUserData()
        if model.wxOpenId.count > 0 {
            self.labWx.text = "微信解绑"
        }else{
            self.labWx.text = "微信绑定"
        }
        
        let m : ModelUser = CommonTool.unarhiveUserData()
        self.labPhoneNumber.text = "手机号 " + self.kdealMobile(str: m.mobile ) + "已绑定"
        
    }
    func kdealMobile(str:String) -> String{
        if str.count == 0 {
            return ""
        }
        let newStr:String = str
        let strPre = newStr.prefix(3)
        let strEnd = newStr.suffix(4)
        return strPre + "****" + strEnd
    }
    
    let fileManager = FileManager.default
    func fileSizeOfCache()-> Float {
        
//        // 获取Caches目录路径和目录下所有文件
        var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        cachePath.append("/xg")
        guard let files = fileManager.subpaths(atPath: cachePath)
        else{
            return 0
        }
        var fsize: Float = 0
        for file in files {
            let path = cachePath + ("/\(file)")
            fsize += fileSizeAtPath(path: path)
        }
        if  (fsize / (1024*1024) < 1) {
            return 0
        }
        return  fsize / (1024*1024)
    }
    
    func fileSizeAtPath(path:String) -> Float{

        if fileManager.fileExists(atPath: path) {
            let attr = try! fileManager.attributesOfItem(atPath: path)
            return Float(attr[FileAttributeKey.size] as! UInt64)
        }
        return 0
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    func setupViews() {
        
    }
    func requestData(){
        
    }
    
    
    @IBAction func btnActionMyInfo(_ sender: UIButton) {
        let vc = MyInfoViewController() 
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func btnActionChangePW(_ sender: UIButton) {
    }
    
    @IBAction func btnActionPhoneNumber(_ sender: UIButton) {
    }
    
    @IBAction func btnActionWX(_ sender: UIButton) {
        let str = labWx.text
        if str == "微信绑定"{
            CommonTool.thirdLoginInfo(.wechatSession, success: { (res) in
                let openid = res.openid
                let unionId = res.unionId
                self.requetDataBind(openid: openid!, unionid: unionId!,type: .wechatSession)
            },fail:  { (err) in
                CommonTool.showFail(view: self.view, text: "微信打开失败")
            })
        }else if str == "微信解绑"{
            requestDataUnbind(type: .wechatSession)
        }
        
        
    }
    
    func requestDataUnbind(type:UMSocialPlatformType){
        let param:ParamThirdBind = ParamThirdBind()
        switch type {
        case .wechatSession:
            param.type = 0
        case .QQ:
            param.type = 1
        case .sina:
            param.type = 2
        default:
            param.type = 0
        }
        
        
        
        MeTool.thridUnbind(params: param.toJSON()!, success: { ( res) in
            if res.success{
                
                let model: ModelUser = CommonTool.unarhiveUserData()
                switch type {
                case .wechatSession:do{
                    self.labWx.text = "微信绑定"
                    CommonTool.showSuccess(view: self.view, text: "微信解绑成功")
                    model.wxUnionId = ""
                    model.wxOpenId = ""
                    break}
                case .QQ:do{
                    self.labQQ.text = "QQ绑定"
                    CommonTool.showSuccess(view: self.view, text: "QQ解绑成功")
                    model.qqUnionId = ""
                    break}
                case .sina:do{
                    self.labQQ.text = "新浪微博绑定"
                    CommonTool.showSuccess(view: self.view, text: "新浪微博解绑成功")
                    model.qqUnionId = ""
                    break}
                default:do{
                    break}
                }
                CommonTool.archiveUserDataWith(user: model)
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    func requetDataBind(openid:String, unionid:String,type:UMSocialPlatformType){
        
        let param:ParamThirdBind = ParamThirdBind()
    
        switch type {
        case .wechatSession:
            param.type = 0;
        case .QQ:
            param.type = 1;
        case .sina:
            param.type = 2;
        default:
            param.type = 0;
        }
        param.openId =  openid
        param.unionId =  unionid
        
        MeTool.thridBind(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let model: ModelUser = CommonTool.unarhiveUserData()
                switch type {
                case .wechatSession:do{
                    self.labWx.text = "微信解绑"
                    CommonTool.showSuccess(view: self.view, text: "微信绑定成功")
                    model.wxUnionId = unionid
                    model.wxOpenId = openid
                    break}
                case .QQ:do{
                    self.labQQ.text = "QQ解绑"
                    CommonTool.showSuccess(view: self.view, text: "QQ绑定成功")
                    model.qqUnionId = unionid
                    break}
                case .sina:do{
                    self.labQQ.text = "新浪微博解绑"
                    CommonTool.showSuccess(view: self.view, text: "新浪微博绑定成功")
                    model.qqUnionId = unionid
                    break}
                default:do{
                    break}
                }
                CommonTool.archiveUserDataWith(user: model)
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
    }
    
    @IBAction func btnActionQQ(_ sender: UIButton) {
        let str = labQQ.text
        if str == "QQ未绑定"{
            CommonTool.thirdLoginInfo(UMSocialPlatformType.qzone, success: { (res) in
                let openid = res.openid
                let unionId = res.unionId
                self.requetDataBind(openid: openid!, unionid: unionId!,type: .QQ)
            },fail:  { (err) in
                CommonTool.showFail(view: self.view, text: "QQ打开失败")
            })
        }else if str == "QQ解绑"{
            requestDataUnbind(type: .QQ)
        }
        
    }
    
    @IBAction func btnActionWB(_ sender: UIButton) {
        let str = labSina.text
        if str == "新浪微博未绑定"{
            CommonTool.thirdLoginInfo(.sina, success: { (res) in
                let openid = res.openid
                let unionId = res.unionId
                self.requetDataBind(openid: openid!, unionid: unionId!,type: .sina)
            },fail:  { (err) in
                CommonTool.showFail(view: self.view, text: "新浪微博打开失败")
            })
        }else if str == "新浪微博解绑"{
            requestDataUnbind(type: .sina)
        }
        
    }
    
    @IBAction func btnActionCaches(_ sender: UIButton) {
        CommonTool.showLoadingWithMessage(view: self.view, message: "clearing")
        var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        cachePath.append("/xg")
        guard let files = fileManager.subpaths(atPath: cachePath)
            else{
                
                CommonTool.hideLoading(view: self.view)
                return
            }
        for file in files {
            let path = cachePath + ("/\(file)")
            try! FileManager.default.removeItem(atPath: path)
        }
        CommonTool.hideLoading(view: self.view)
        
        CommonTool.showSuccess(view: self.view, text: "clear success")
        self.labCaches.text = "0.00Mb"
    }
    
    
    @IBAction func btnActionVersion(_ sender: UIButton) {
    }
    @IBAction func btnActionUnLogin(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isLogin")
        
        self.navigationController?.popViewController(animated: true)
        
        
        
        tabbar = RootViewController.init()
        
        kaddChildVc(vc: HomeViewController(), title: "首页", imageName: "tab_home", imageSelect: "tab_home_sel");
        kaddChildVc(vc: CourseViewController(), title: "课程", imageName: "tab_course", imageSelect: "tab_course_sel");
        kaddChildVc(vc: QAViewController(), title: "问答", imageName: "tab_qa", imageSelect: "tab_qa_sel");
        kaddChildVc(vc: MeViewController(), title: "我的", imageName: "tab_me", imageSelect: "tab_me_sel");
        
        UIApplication.shared.keyWindow?.rootViewController = tabbar
    }
    
    func kaddChildVc(vc: UIViewController, title: String , imageName: String, imageSelect: String)  {
        vc.tabBarItem.title = title
        let att = NSDictionary.init(object: UIColor.colorWithHex(hexStr: "54C67B"), forKey: NSAttributedString.Key.foregroundColor as NSCopying)
        vc.tabBarItem.setTitleTextAttributes(att as! [NSAttributedString.Key : Any], for: .selected)
        
        let selImg = UIImage.init(named: imageSelect)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selImg
        vc.tabBarItem.image = UIImage.init(named: imageName)
        
        let nav = UINavigationController.init(rootViewController: vc)
        nav.title = title
        nav.hidesBottomBarWhenPushed = true
        tabbar?.addChild(nav)
        
    }
    
    
}

