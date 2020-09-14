//
//  ParamLogin.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/20.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit 

// 登录
class ParamLogin : BaseParam{
    var mobile:String?
    var password:String?
}
class ParamLoginThird:BaseParam{
    var type:Int?  //type   0://微信，1://QQ，2://新浪微博
    var unionId:String?
}
class ParamGetVCode: BaseParam {
    
    var mobile:String?
    var type:String? // 1 获取验证码 注册时
  
}
class ParamVerifyCode : BaseParam{
    var mobile:String?
    var code: String?
    var type: String? // 1 验证验证码 注册时
}
class ParamSettingPw: BaseParam { 
    var mobile:String?
    var loginPassword:String?
}
class ParamRegister: ParamSettingPw{
    
}
 
