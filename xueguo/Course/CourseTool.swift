//
//  CourseTool.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseTool: NSObject {

    /**
     * 根据课程查教师及clo的最新回复
     */
    static func requestGetTeacherWithClo(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.getTeacherByClo.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                var arr = [ModelTeacher]()
                if res.success {
                    for dict in rep["data"] as! [Dictionary<String, Any>]{
                        let m:ModelTeacher = ModelTeacher.deserialize(from: dict)!
                        arr.append(m)
                    }
                }
                 res.arr = arr
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    /**
     * 回复、追问消息
     */
    static func requestCloAddMessage(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.cloAddMessage.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    /**
     * 课程成果-消息 列表
     */
    static func requestCloMessageList(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.cloMessageList.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data: [String:Any] = (json!["data"].rawValue as? [String:Any])!
                let model :ModelCloMessageList = ModelCloMessageList.deserialize(from: data)!
                res.data = model
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    /**
     * 获取当前分组
     */
    static func getCurrentGroup(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.getCurrentGroup.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data: [String:Any] = (json!["data"].rawValue as? [String:Any])!
                let model :ModelGetCurrentGroup = ModelGetCurrentGroup.deserialize(from: data)!
                res.data = model
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    /**
     * 作业详情
     */
    static func workDetail(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.workDetail.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data: [String:Any] = (json!["data"].rawValue as? [String:Any])!
                let model :ModelWorkDetail = ModelWorkDetail.deserialize(from: data)!
                res.data = model
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    /**
     * 评核任务详情
     */
    static func taskDetail(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.taskDetail.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data: [String:Any] = (json!["data"].rawValue as? [String:Any])!
                let model :ModelTaskDetail = ModelTaskDetail.deserialize(from: data)!
                res.data = model
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    /**
     * 课程资料
     */
    static func courseInfomation(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.courseInfomation.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelCourseInfomation]()
                let dataList = json!["data"]["list"].rawValue
                
                
                
                if dataList != nil {
                    for dic in dataList as! [[String:Any]] {
                                       
                       let m:ModelCourseInfomation = ModelCourseInfomation.deserialize(from: dic)!
                       let fileName = m.url.components(separatedBy: "/").last
                       m.fileIsExist = ZCachesTool.fileExist(fileName: fileName ?? "")
                       if m.fileIsExist {
                           var caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
                           caches?.append("/file/")
                           caches?.append(fileName ?? "")
                           m.filePath = caches!
                       }
                       list.append(m)
                   }
                       res.arr = list
                }
                
               
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    
    /**
     * 课程学果
     */
    static func courseAchievement(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.courseAchievement.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelCourseAchievement]()
                let dataList = json!["data"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelCourseAchievement = ModelCourseAchievement.deserialize(from: dic)!
                    list.append(m)
                }
                res.arr = list
                
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    
    
    /**
     * 分值结构
     */
    static func courseScoreStruct(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.courseScoreStruct.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data: [String:Any] = (json!["data"].rawValue as? [String:Any])!
                let model :ModelCourseScoreStruct = ModelCourseScoreStruct.deserialize(from: data)!
                res.data = model
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    /**
     * courseDetail
     */
    static func courseDetail(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.courseDetail.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data: [String:Any] = (json!["data"].rawValue as? [String:Any])!
                let model :ModelCourseDtail = ModelCourseDtail.deserialize(from: data)!
                res.data = model
                
                
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    /**
     * courseList
     */
    static func courseList(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Course.courseList.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelCourseList]()
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelCourseList = ModelCourseList.deserialize(from: dic)!
                    list.append(m)
                }
                res.arr = list
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
}
