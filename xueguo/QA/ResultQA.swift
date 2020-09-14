//
//  ResultQA.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/28.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import HandyJSON
class Z_HandyJSON: HandyJSON {
    required init(){}
}

class ResultQA: BaseResult {

}
class ModelQaListAnswer: HandyJSON {
    required init() {}
    var studentSex:String = ""
    var teacherSex:String = ""
    var answer:String = ""
    var createTime:String = ""
    var deleteTime:String = ""
    var id:String = ""
    var questionId:String = ""
    var status:Int = -1 // 0 1 未采纳 已采纳
    var studentId:String = ""
    var studentName:String = ""
    var teacherId:String = ""
    var teacherName:String = ""
    var type:Int = -1  // 0 1  回答 追问
    var updateTime:String = ""
}
class ModelQaAnswer:ModelQaListAnswer{
    
}
class ModelQaDetail:HandyJSON{
    required init() {}
//    var ztype:Int = 0// 自己添加标记类型 0 1 2 问 追问 回答
    var studentSex:String = ""
    var academyId:String = ""
    var academyName:String = ""
    var answerCount:String = ""
    var answerList:[ModelQaAnswer] = [ModelQaAnswer]()
    var classId:String = ""
    var className:String = ""
    var collegeId:String = ""
    var createTime:String = ""
    var deleteTime:String = ""
    var id:String = ""
    var question:String = ""
    var status:String = ""
    var studentAvatar:String = ""
    var studentId:String = ""
    var studentName:String = ""
    var teacherAvatar:String = ""
    var teacherId:String = ""
    var teacherName:String = ""
    var updateTime:String = ""
}
class ModelQaList:HandyJSON,NSCopying  {
    
    func copy(with zone: NSZone? = nil) -> Any {
        
        // 使用 div 助手转译生成
        let model = ModelQaList.init()
        model.teacherSex = teacherSex
        model.academyId = academyId
        model.academyName = academyName
        model.answerCount = answerCount
        model.classId = classId
        model.className = className
        model.collegeId = collegeId
        model.createTime = createTime
        model.deleteTime = deleteTime
        model.id = id
        model.question = question
        model.status = status
        model.studentAvatar = studentAvatar
        model.studentId = studentId
        model.studentName = studentName
        model.teacherAvatar = teacherAvatar
        model.teacherId = teacherId
        model.teacherName = teacherName
        model.updateTime = updateTime
        model.unReadCount = unReadCount
        
        let modelAnswer = ModelQaListAnswer()
        
        model.answer = modelAnswer
        modelAnswer.answer = answer!.answer
        modelAnswer.createTime = answer!.createTime
        modelAnswer.deleteTime = answer!.deleteTime
        modelAnswer.id = answer!.id
        modelAnswer.questionId = answer!.questionId
        modelAnswer.status = answer!.status
        modelAnswer.studentId = answer!.studentId
        modelAnswer.studentName = answer!.studentName
        modelAnswer.teacherId = answer!.teacherId
        modelAnswer.teacherName = answer!.teacherName
        modelAnswer.type = answer!.type
        modelAnswer.updateTime = answer!.updateTime


        return model
    }
    
  
    
    
    required init() {}
    var teacherSex:String = ""
    var answer: ModelQaListAnswer?
    var academyId:String = ""
    var academyName:String = ""
    var answerCount:String = ""
    var classId:String = ""
    var className:String = ""
    var collegeId:String = ""
    var createTime:String = ""
    var deleteTime:String = ""
    var id:String = ""
    var question:String = ""
    var status:Int = 0  // 012  未答 已答  已采纳
    var studentAvatar:String = ""
    var studentId:String = ""
    var studentName:String = ""
    var teacherAvatar:String = ""
    var teacherId:String = ""
    var teacherName:String = ""
    var updateTime:String = ""
    var unReadCount: Int = 0
    
}
class ModelTeacher:HandyJSON{
    required init() {}
    var name:String = ""
    var avatar:String = ""
    var sex:String = ""
    var isReply:String = ""
    var scorMap:String = ""
    
    var address:String = ""
    var area:String = ""
    var birthday:String = ""
    var business:String = ""
    var cardNo:String = ""
    var city:String = ""
    var collegeId:String = ""
    var createTime:String = ""
    var createUser:String = ""
    var degree:String = ""
    var deleteTime:String = ""
    var education:String = ""
    var entryTime:String = ""
    var graduateCollege:String = ""
    var graduateMajor:String = ""
    var id:String = ""
    var isStaff:String = ""
    var mobile:String = ""
    var political:String = ""
    var province:String = ""
    var reason:String = ""
    var status:String = ""
    var teacherName:String = ""
    var teacherNo:String = ""
    var teacherType:String = ""
    var updateTime:String = ""
    var updateUser:String = ""
    var verifyTime:String = ""

}
