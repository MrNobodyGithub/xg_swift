//
//  MeTool.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/22.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import SwiftyJSON

class MeTool: NSObject {

    /**
     * 收藏、取消收藏
     */
    static func collectionAddOrDel(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.colAddOrDel.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success { 
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    /**
     *  我的收藏
     */
    static func collection(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.collection.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelCollection]()
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelCollection = ModelCollection.deserialize(from: dic)!
                   
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
     * 职位列表
     */
    static func position(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.position.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelPosition]()
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelPosition = ModelPosition.deserialize(from: dic)!
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
     * 行业列表
     */
    static func industry(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.industry.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rawValue: rep)
                var list = [ModelIndustry]()
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelIndustry = ModelIndustry.deserialize(from: dic)!
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
     * 就业登记列表
     */
    static func jobList(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.jobList.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                
                let json = JSON.init(rawValue: rep)
                var list = [ModelJobList]()
                let data = json!["data"]
                res.total = data["total"].rawValue as! Int
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelJobList = ModelJobList.deserialize(from: dic)!
                    list.append(m)
                }
                res.arr = list
                
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    
    // 三方解绑
    static func thridUnbind(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.thirdUnbind.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                
            }
            success(res)
        }, fail: {(err) in
            fail(err)
        })
    }
    // 三方绑定
    static func thridBind(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.thridBind.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
            }
            success(res)
        }, fail: {(err) in
            fail(err)
        })
    }
    
    
    // 获得个人信息
    static func getUserInfo(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.getUserInfo.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                guard let data:NSDictionary = (rep["data"] as! NSDictionary) else {
                    success(res)
                    return
                }
                let model = ModelUser.deserialize(from: data)
                CommonTool.archiveUserDataWith(user: model!)
            }
            success(res)
        }, fail: {(err) in
            fail(err)
        })
    }
    
    // 更新密码 -> 忘记密码时 使用验证码更新密码
    static func updatePw(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.updatePw.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
//                guard let data:NSDictionary = (rep["data"] as! NSDictionary) else {
//                    success(res)
//                    return
//                }
//                let model = ModelUser.deserialize(from: data)
//                CommonTool.archiveUserDataWith(user: model!)
            }
            success(res)
        }, fail: {(err) in
            fail(err)
        })
    }
    // 更新个人信息
    static func updateInfo(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Me.updateUserInfo.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                guard let data:NSDictionary = (rep["data"] as! NSDictionary) else {
                    success(res)
                    return
                }
                let model = ModelUser.deserialize(from: data)
                CommonTool.archiveUserDataWith(user: model!)
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
}
