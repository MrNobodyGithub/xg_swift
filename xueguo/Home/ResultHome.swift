//
//  ResultHome.swift
//  xueguo
//
//  Created by CityMedia on 2019/8/10.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit


class ResultHome: NSObject {

}

class ModelLearnRes: Z_HandyJSON {
    var courseId:String = ""
    var courseName:String = ""
    var count:String = ""

}
class ModelMission: Z_HandyJSON { 
    var schoolList:[ModelMission_School] = []
    var collegeList:[ModelMission_College] = []
}

class ModelMission_College: ModelMission_School {
    
}
class ModelMission_School: Z_HandyJSON {
    var schoolLogo:String = ""
    var schoolName:String = ""
    var id:String = ""
    var parentId:String = ""
    var title:String = ""
    var content:String = ""
    var sort:String = ""
    var year:String = ""
    var fromId:String = ""
    var academyId:String = ""
    var academyName:String = ""
    var collegeId:String = ""
    var createUser:String = ""
    var createTime:String = ""
    var updateUser:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    var academyTitle:String = ""
    var data:[ModelMission_School_Data] = []

}
class ModelMission_School_Data:Z_HandyJSON{
    var academyId:String = ""
    var academyName:String = ""
    var academyTitle:String = ""
    var collegeId:String = ""
    var content:String = ""
    var createTime:String = ""
    var createUser:String = ""
    var data:String = ""
    var deleteTime:String = ""
    var fromId:String = ""
    var id:String = ""
    var parentId:String = ""
    var sort:String = ""
    var title:String = ""
    var updateTime:String = ""
    var updateUser:String = ""
    var year:String = ""

}
class ModelNotification: Z_HandyJSON {
    var noticeId:String = ""
    var collegeId:String = ""
    var noticeType:String = ""
    var senderId:String = ""
    var groupId:String = ""
    var noticeTag:String = ""
    var noticeTitle:String = ""
    var noticeContent:String = ""
    var pubState:String = ""
    var receiverId:String = ""
    var readState:String = ""
    var readTime:String = ""

}
class ModelBanner: Z_HandyJSON {
    var id:String = ""
    var linkTitle:String = "" //linkTitle 标题
    var linkType:String = ""//linkType 1-轮播图 2-友情链接 3-广告位
    var linkUrl:String = ""
    var linkImage:String = ""
    var linkTarget:String = ""
    var linkLocation:String = ""//linkLocation 广告位位置
    var pubState:String = "" //pubState 发布状态 0-未发布 1-已发布
    var createTime:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    var createUser:String = ""
    var sort:String = ""

}
