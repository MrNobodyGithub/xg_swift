//
//  HomeTool.swift
//  xueguo
//
//  Created by CityMedia on 2019/8/10.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import SwiftyJSON
class HomeTool: NSObject {
   
    /**
     *  根据用户登录的token来获取未读通知列表（首页通知提醒）
     */
    static func checkNotification(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Home.notificationCheck.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
 
    /**
     * 学习资源
     */
    static func learnRes(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Home.learnResource.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelLearnRes]()
//                let data = json!["data"][""]
//                res.total = data["total"].rawValue as! Int
                let dataList = json!["data"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelLearnRes = ModelLearnRes.deserialize(from: dic)!
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
     * 院系使命
     */
    static func mission(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Home.getMissionListById.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                let data: [String:Any] = (json!["data"].rawValue as? [String:Any])!
                let model :ModelMission = ModelMission.deserialize(from: data)!
                res.data = model
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    /**
     * 更新已读标识
     */
    static func updateNotification(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Home.updateNofication.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success { 
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    /**
     * 阅读通知
     */
    static func notificationRead(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Home.selectNoticeById.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
             
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    /**
     * 根据用户登录的token来获取通知列表
     */
    static func notificationList(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Home.notificationList.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelNotification]()
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelNotification = ModelNotification.deserialize(from: dic)!
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
     * banner
     */
    static func banner(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Home.banner.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success { 
                let json = JSON.init(rawValue: rep)
                var list = [ModelBanner]()
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelBanner = ModelBanner.deserialize(from: dic)!
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
