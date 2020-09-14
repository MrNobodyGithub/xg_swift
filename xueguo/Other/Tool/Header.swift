//
//  Header.swift
//  xueguo
//  Created by CityMedia on 2019/5/19.
//  Copyright © 2019 free. All rights reserved.
//
// ys.h_全局地址

import UIKit

var TESTFlAG:Bool = false

//let BaseUrl : String = "http://api-stu.qdforbetter.com"
let BaseUrl : String = "http://testapp.ixueguo.com"


enum CUSURL {
    enum Home{
        case banner,notificationList,selectNoticeById,updateNofication,getMissionListById,learnResource,notificationCheck
        func url() -> String{
            switch self {
                
            case .notificationCheck: return BaseUrl + "/api/notice/selectNoticeCheck" //根据用户登录的token来获取通知列表
            case .learnResource: return BaseUrl + "/api/course/getLearningResource" //院系使命
            case .getMissionListById: return BaseUrl + "/api/college/mission/getMissionListById" //院系使命
            case .updateNofication: return BaseUrl + "/api/notice/updateReadState" //更新已读标识
            case .selectNoticeById: return BaseUrl + "/api/notice/selectNoticeById" //阅读通知
            case .notificationList: return BaseUrl + "/api/notice/selectNoticeCheck"
            case .banner: return BaseUrl + "/api/link/list"
            
            }
        }
    }
    enum QA{
        case getTeacherList,add,listOrSearch,detail,askAgain,repealQa,accept
        func url() -> String{
            switch self {
            case .accept: return BaseUrl + "/api/question/acceptAnswer"
            case .repealQa: return BaseUrl + "/api/question/repealQuestion"
            case .askAgain: return BaseUrl + "/api/question/addAnswer"
            case .detail: return BaseUrl + "/api/question/detail"
            case .listOrSearch: return BaseUrl + "/api/question/list"
            case .add: return BaseUrl + "/api/question/add"
            case .getTeacherList: return BaseUrl + "/api/college/teacher/getTeacherByStudentId"
            }
        }
    }
    enum Course {
        case courseList,courseDetail,courseScoreStruct,courseAchievement,courseInfomation,taskDetail,workDetail,getCurrentGroup,getStudentMutualScore,addStudentMutualScore,increaseViews,addResourceSrc,updateTaskDetail,getResourcesByUserId,cloMessageList,cloAddMessage,getTeacherByClo
        func url() -> String{
            switch self {
            case .getTeacherByClo: return BaseUrl + "/api/course/getTeacherByClo" //根据课程查教师及clo的最新回复
            case .cloAddMessage: return BaseUrl + "/api/question/addAnswer"//回复、追问消息
            case .cloMessageList: return BaseUrl + "/api/question/cloDetail" // 成果消息列表
            case .getResourcesByUserId: return BaseUrl + "/api/course/getResourcesByUserId"//个人收藏列表
            case .updateTaskDetail: return BaseUrl + "/api/course/updateTaskDetail"//申请修改作业
            case .addResourceSrc: return BaseUrl + "/api/resourceSrc/addResourceSrc"//新增资源（作业）
            
                
            case .increaseViews: return BaseUrl + "/api/resourceSrc/increaseViews"//增加浏览记录
 
            case .addStudentMutualScore: return BaseUrl + "/api/course/addStudentMutualScore" //学生互评保存
            case .getStudentMutualScore: return BaseUrl + "/api/course/getStudentMutualScore" // 根据评核项目作业ID查学生互评信息
            case .getCurrentGroup: return BaseUrl + "/api/course/getCurrentGroup"
            case .workDetail: return BaseUrl + "/api/course/getTaskDetails"
                //评核任务详情
            case .taskDetail: return BaseUrl + "/api/course/getMissionDetails"
            case .courseInfomation: return BaseUrl + "/api/course/getCoursewareMaterials"
            case .courseAchievement: return BaseUrl + "/api/course/getCloByCourseId"
            case .courseList: return BaseUrl + "/api/course/getCourseList"
            case .courseDetail: return BaseUrl + "/api/course/getCoursebyId"
            case .courseScoreStruct: return BaseUrl + "/api/course/getScoreStructure"
            }
        }
    }
    enum Login {
        case getVcode,register ,verifyCode, login,updatePw,thirdLogin
        func url() -> String {
            switch self {
            case .thirdLogin: return BaseUrl + "/api/student/thirdLogin"
            case .updatePw: return BaseUrl + "/api/student/updatePassword"
            case .login: return BaseUrl + "/api/student/login"
            case .getVcode:  return BaseUrl + "/api/common/getCode"
            case .register: return BaseUrl + "/api/student/register"
            case .verifyCode: return BaseUrl + "/api/common/verifyCode" // 校验验证码 带更改
            }
        }
    }
    enum Me {
        case updateUserInfo, getUserInfo,thridBind,thirdUnbind,jobList,industry,position,collection
        ,colAddOrDel,chooseIndustry
        func url() -> String{
            switch self {
            case .chooseIndustry: return BaseUrl + "/api/course/getIndustryList" // 行业选择
            case .colAddOrDel: return BaseUrl + "/api/resourceSrc/increaselikes" // 收藏or 取消
            case .collection: return BaseUrl + "/api/course/getResourcesByUserId" //我的收藏
            case .position: return BaseUrl + "/api/course/getPositionList" //职位列表
            case .industry: return BaseUrl + "/api/course/getIndustryList" //行业列表
            case .jobList: return BaseUrl + "/api/course/getStudentJobByUserId" //就业登记列表
            case .thirdUnbind: return BaseUrl + "/api/student/thirdUnbind"
            case .thridBind: return BaseUrl + "/api/student/thirdBind"
            case .updateUserInfo:
                return BaseUrl+"/api/student/updateMessage"
            case .getUserInfo:
                return BaseUrl+"/api/student/getMessage"
            default:
                return BaseUrl
            }
        }
    }
}

//enum House: String {
//    case Baratheon = "Ours is the Fury"
//    case Greyjoy = "We Do Not Sow"
//    case Martell = "Unbowed, Unbent, Unbroken"
//    case Stark = "Winter is Coming"
//    case Tully = "Family, Duty, Honor"
//    case Tyrell = "Growing Strong"
//}

//print (Device.iPhone.introduced())
// prints: "iPhone was introduced 200
