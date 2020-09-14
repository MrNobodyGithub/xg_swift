//
//  LoginTool.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/20.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class LoginTool: NSObject {
 
    /**
     * login
     */
     static func login(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.login.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isLogin")
                defaults.synchronize()
            
                guard let data:NSDictionary = (rep["data"] as! NSDictionary) else {
                    success(res)
                    return
                }
                let model = ModelUser.deserialize(from: data)
                CommonTool.archiveUserDataWith(user: model!)
//                let mm = CommonTool.unarhiveUserData()
                //                createTime = "2019-05-21 13:35:42";
//                isReading = 1;
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    static func thirdLogin(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.thirdLogin.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success{
                
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    static func settingPw(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.verifyCode.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    static func verifyVcode(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.verifyCode.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    static func getVcode(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.getVcode.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    static func register(params: [String : Any],  success:@escaping (_ result: BaseResult) -> () ,fail:@escaping(_ error: Error) -> ()){
        
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.register.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
//            res.data
            if res.success {
                guard let data:NSDictionary = (rep["data"] as! NSDictionary) else {
                    success(res)
                    return
                }
                let model = ModelUser.deserialize(from: data)
                CommonTool.archiveUserDataWith(user: model!)
                let mm = CommonTool.unarhiveUserData()
            }else{
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
   
}
