//
//  ParamHome.swift
//  xueguo
//
//  Created by CityMedia on 2019/8/10.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class ParamHome: NSObject {

}

class ParamCheckNotification: BaseParam {
    var receiverId :String?
}
class ParamMission: BaseParam {
    var academyId:String?
    var collegeId:String?
}
class ParamNotificationList:BaseParam{
    var receiverId:String?
    
    //阅读通知
    var noticeId:String?
    
}
class ParamBanner: BaseParamPage {
    var pubState:Int?
    
}
