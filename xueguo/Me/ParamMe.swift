//
//  ParamMe.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/22.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class ParamGetUserInfo: BaseParam {
    
}
 
class ParamColAddOrDel: BaseParam {
    var resources:NSInteger? // resources ：1  添加收藏 0取消
    var  resourceSrcId:String = ""
}
class ParamJob: BaseParam {
    var parentCode:String = "0" // 一级 子级  industryCode
}
class ParamThirdBind:BaseParam{
    var type:Int? //type   0://微信，1://QQ，2://新浪微博
    var unionId:String?
    var openId:String?
}
class ParamUpdatePw: BaseParam{
    var mobile:String?
    var password:String?
    var code:String?
}
class ParamUpdateInfo: ParamSettingPw {// 更新个人信息 密码
    
    var classNo:String?
    var sex:String? // 男 女 1 2 other 0
    var studentName:String?
    var studentNo:String?
    var cardID:String?
    
    //    "classNo" : "5555",
    //    "sex" : "2",
    //    "studentName" : "555",
    //    "studentNo" : "5555",
    //    "cardID" : "126665833838638",
    //    "userId" : "3"
}
