//
//  ResultCourse.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class ResultCourse: NSObject {

}

 
class ModelCloMeeeageList_answer: Z_HandyJSON {
    var id:String = ""
    var questionId:String = ""
    var answer:String = ""
    var type:String = ""
    var status:String = ""
    var teacherId:String = ""
    var teacherName:String = ""
    var studentName:String = ""
    var haveRead:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var studentId:String = ""
    var deleteTime:String = ""
    var cloId:String = ""
    var classId:String = ""
    var studentAvatar:String = ""
    var teacherAvatar:String = ""
    var questionStatus:String = ""

}
// 成果消息列表
class ModelCloMessageList:Z_HandyJSON{
    var id:String = ""
    var studentId:String = ""
    var studentName:String = ""
    var question:String = ""
    var cloId:String = ""
    var teacherId:String = ""
    var teacherName:String = ""
    var status:String = ""
    var classId:String = ""
    var className:String = ""
    var collegeId:String = ""
    var academyId:String = ""
    var academyName:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    var studentAvatar:String = ""
    var teacherAvatar:String = ""
    var studentSex:String = ""
    var teacherSex:String = ""
    var answerList:[ModelCloMeeeageList_answer] = []

}


// 获取当前分组
class ModelGetCurrentGroup: Z_HandyJSON {
     
}

// 作业详情 ->resourceSrcList
class ModelWorkDetail_ResourceSrcList: Z_HandyJSON {
    var id:String = ""
    var title:String = ""
    var info:String = ""
    var url:String = ""
    var srcLength:String = ""
    var srcSize:String = ""
    var views:String = ""
    var srcFormat:String = ""
    var srcType:String = ""
    var visible:String = ""
    var likes:String = ""
    var collegeId:String = ""
    var academyId:String = ""
    var majorId:String = ""
    var courseId:String = ""
    var createUser:String = ""
    var updateUser:String = ""
    var publishTime:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    var remark:String = ""
    var createUserName:String = ""
    var srcNotes:String = ""
    var collections:String = ""
}
// 作业详情
class ModelWorkDetail: Z_HandyJSON {
    
    var resourceSrcList:[ModelWorkDetail_ResourceSrcList] = []
    var id:String = ""
    var studentId:String = ""
    var groupId:String = ""
    var classId:String = ""
    var cloId:String = ""
    var evaluateItemId:String = ""
    var content:String = ""
    var evaluateType:String = ""
    var taskType:String = ""
    var resources:String = ""
    var evaluateScaleId:String = ""
    var studentRate:String = ""
    var studentScore:String = ""
    var companyId:String = ""
    var companyRate:String = ""
    var companyScore:String = ""
    var companyRateTime:String = ""
    var taskRate:String = ""
    var bonusRate:String = ""
    var bonusReason:String = ""
    var minusRate:String = ""
    var minusReason:String = ""
    var teacherRate:String = ""
    var teacherScore:String = ""
    var teacherRateTime:String = ""
    var teacherId:String = ""
    var headInStatus:String = ""
    var headInTime:String = ""
    var applyModify:String = ""
    var modifyRemark:String = ""
    var applyTime:String = ""
    var createUser:String = ""
    var updateUser:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    var remark:String = ""
    var teacherName:String = ""
    var companyName:String = ""
    var settingCompanyScore:String = ""
    var settingTeacherScore:String = ""
    var settingStudentScore:String = ""
    var courseId:String = ""
    var endTime:String = ""
    var isDelay:String = ""
    var groupMasterId:String = ""
    var group:String = ""


}

// 任务详情
class ModelTaskDetail: Z_HandyJSON {
    var cloEvaluate: ModelTaskDetail_Clo = ModelTaskDetail_Clo.init()
    var evaluateItemList: [ModelTaskDetail_Item] = []
}

// 任务详情 -> evaluateItemList // 新内容待定
class ModelTaskDetail_Item: Z_HandyJSON{
    var id:String = ""
    var classEvaluateId:String = ""
    var evaluateItemId:String = ""
    var classId:String = ""
    var className:String = ""
    var content:String = ""
    var evaluateScaleId:String = ""
    var taskGroup:String = ""
    var groupNum:String = ""
    var groupStyle:String = ""
    var examType:String = ""
    var examName:String = ""
    var examTitle:String = ""
    var isDelay:String = ""
    var deleteTime:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var ploId:String = ""
    var finishTime:String = ""
    var sort:String = ""
    var finishStatus:String = ""
    var endTime:String = ""

}
// 任务详情 -> cloEvaluate
class ModelTaskDetail_Clo: Z_HandyJSON {
    var id:String = ""
    var courseId:String = ""
    var cloId:String = ""
    var sort:String = ""
    var deleteTime:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var taskName:String = ""
    var taskContent:String = ""
    var score:String = ""
    var released:String = ""
    var releaseName:String = ""
    var releaseTime:String = ""
    var cloCode:String = ""
    var classId:String = ""
}


// 课程资料
class ModelCourseInfomation: Z_HandyJSON {
    var filePath:String = ""
    var fileIsExist:Bool = false
    var id:String = ""
    var title:String = ""
    var info:String = ""
    var url:String = ""
    var srcLength:String = ""
    var srcSize:String = ""
    var views:String = ""
    var srcFormat:String = ""
    var srcType:String = ""
    var visible:String = ""
    var likes:String = ""
    var collegeId:String = ""
    var academyId:String = ""
    var majorId:String = ""
    var courseId:String = ""
    var createUser:String = ""
    var updateUser:String = ""
    var publishTime:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    var remark:String = ""
    var createUserName:String = ""
    var srcNotes:String = ""
    var collections:String = ""
}
// 课程成果
class ModelCourseAchievement: Z_HandyJSON {
    var code:String = ""
    var count:String = ""
    var id:String = ""
    var title:String = ""
    var credit:String = ""
    var score:String = ""
    var info:String = ""
    var scoreVoList:[ModelCourseAchievementVloList] = []
}
// 课程成果 -> 任务
class ModelCourseAchievementVloList: Z_HandyJSON {
    var credit:String = ""
    var score:String = ""
    var achievement:String = ""
    var title:String = ""
    var id:String = ""
    var status:String = ""
}
class ModelCourseScoreStruct: Z_HandyJSON {
    var credit:String = ""
    var score:String = ""
    var title:String = ""
    var id:String = ""
    var processEvaluateScore:String = ""
    var processEvaluateTitle:String = ""
    var processEvaluateList:[ModelCourseProcessEvaluateList] = []
    var cloEvaluateList:[ModelCourseCloEvaluateList] = []
  
}
class ModelCourseCloEvaluateList: Z_HandyJSON {
    var id:String = ""
    var title:String = ""
    var credit:String = ""
    var score:String = ""
    var info:String = ""
    var scoreVoList:[ModelCourseScoreVoList] = []
    
}
class ModelCourseScoreVoList: Z_HandyJSON {
    var credit:String = ""
    var score:String = ""
    var achievement:String = ""
    var title:String = ""
    var id:String = ""
    var status:String = "" 
}
class ModelCourseProcessEvaluateList: ModelCourseScoreVoList {
}


class ModelCourseList:Z_HandyJSON{
    var completedCount:String = ""
    var courseCate:String = ""
    var courseId:String = ""
    var courseName:String = ""
    var credit:String = ""
    var incompleteCount:String = ""
    var isReply:String = ""
    var status:String = ""
    //课程状态  0-未开始  1-进行中 2-收集中 3-已经结束 4：测评中
    //                            // 目前 不传对应所有  进行中 1 成果开启 2 已完成 3
    var studentScore:String = ""
    var subtasksCount:String = ""
    var unopenedCount:String = ""
     
}
class ModelCourseDtail:Z_HandyJSON{
    var id:String = ""
    var ploId:String = ""
    var majorId:String = ""
    var courseName:String = ""
    var courseCode:String = ""
    var courseCate:String = ""
    var courseType:String = ""
    var courseRank:String = ""
    var auditStatus:String = ""
    var auditUser:String = ""
    var auditCompleted:String = ""
    var auditCompUser:String = ""
    var auditCompRemark:String = ""
    var status:String = ""
    var grade:String = ""
    var startYear:String = ""
    var endYear:String = ""
    var startSemester:String = ""
    var endSemester:String = ""
    var credits:String = ""
    var totalCoursePeriod:String = ""
    var courseTarget:String = ""
    var remark:String = ""
    var released:String = ""
    var releaseTime:String = ""
    var beforeCourse:String = ""
    var afterCourse:String = ""
    var togetherCourse:String = ""
    var textbook:String = "" 
    var createTime:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    var createUser:String = ""
    var updateUser:String = ""
    var buildChargeId:String = ""
    var buildChargeCode:String = ""
    var buildChargeName:String = ""
    var postCluster:String = ""
    var post:String = ""
    var typicalTasks:String = ""
    var reference:String = ""
    var otherReference:String = ""
    var theoryCredits:String = ""
    var practiceCredits:String = ""
    var theoryPeriod:String = ""
    var practicePeriod:String = ""
    var totalScore:String = ""
    var cloScore:String = ""
    var processScore:String = ""
    var passScore:String = ""
    var failRule:String = ""
    var schedulingStatus:String = ""
    var courseScore:String = ""
    var coursePloMaps:String = ""
    var credit:String = ""
    var score:String = ""
    var completionDegree:String = ""
    var cloCount:String = ""
    var evaluateCount:String = ""
    
    var teacherList:[ModelTeacher] = []
}


