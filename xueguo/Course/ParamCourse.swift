//
//  ParamCourse.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class ParamCourse: NSObject {

}
//getTeacherByClo  根据课程查教师及clo的最新回复
class ParamGetTeacherByClo: Z_HandyJSON {
    var courseId:String?
    var cloId :String?
//    courseId": "122",
//    "cloId": "161"
}
class ParamCloAddMessage: Z_HandyJSON {
    var questionId:Int?
    var type = 1
    var answer:String = ""
    var teacherId:Int?
}
// 成果消息列表
class ParamCloMessageList: Z_HandyJSON {
    var studentId:Int?
    var cloId:Int?
    var teacherId:Int?
}

// 获取当前分组
class ParamGetCurrentGroup: BaseParam {
    var  groupRuleId :String?
}
//作业详情
class ParamWorkDetail:BaseParam{
    var evaluateItemId:String?
}
class ParamTaskDetail: BaseParam {
    var evaluateId:String?
}
class ParamCourseList: BaseParamPage {
    var status:String? //  0-未开始  1-进行中 2-收集中 3-已经结束 4：测评中
    var year:Int?
    var homePage:Int?
    var grade:Int?
    var stuedendId:String?
}
class ParamCourseDetail:BaseParam{
    var courseId:String?
}
