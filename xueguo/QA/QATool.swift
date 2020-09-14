//
//  QATool.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/28.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import SwiftyJSON


class QATool: NSObject {
    
    static func accept(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.QA.accept.url(), params: params, success: { (rep) in
            let res:BaseResult = BaseResult.deserialize(from: rep)!
            if res.success {
                
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    static func repealQa(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.QA.repealQa.url(), params: params, success: { (rep) in
            let res:BaseResult = BaseResult.deserialize(from: rep)!
            
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    static func askAgain(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.QA.askAgain.url(), params: params, success: { (rep) in
            let res:BaseResult = BaseResult.deserialize(from: rep)!
            
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    static func detail(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.QA.detail.url(), params: params, success: { (rep) in
            let res:BaseResult = BaseResult.deserialize(from: rep)!
            if res.success {
                let json = JSON.init(rep)
                let data: [String:Any] = (json["data"].rawValue as? [String:Any])!
                let model:ModelQaDetail = ModelQaDetail.deserialize(from: data)!
                res.data = model
            }

            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    static func list(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.QA.listOrSearch.url(), params: params, success: { (rep) in
            let res:BaseResult = BaseResult.deserialize(from: rep)!
            if res.success{
                let json = JSON.init(rawValue: rep)
                let data = json!["data"]
                //            let d = c["total"].rawString()
                res.total = data["total"].rawValue as! Int//d!
                
                var list = [ModelQaList]()
                let dataList = data["list"].rawValue
                for dic in dataList as! [Dictionary<String,Any>] {
                    let m:ModelQaList = ModelQaList.deserialize(from: dic)!
                    let hasAnswer = dic.keys.contains("answer")
                    if hasAnswer {
                        let jsona = JSON.init(dic)
                        let dataAnswer = jsona["answer"].rawValue
                        if type(of: dataAnswer) == NSNull.self {
                            m.answer = ModelQaListAnswer.init()
                        }else{
                            let ans = dic["answer"]  as! [String:Any]
                            let msub : ModelQaListAnswer = ModelQaListAnswer.deserialize(from: ans)!
                            m.answer = msub
                        }
                    }else
                    {
                        m.answer = ModelQaListAnswer.init()
                    }
                    list.append(m)
                }
                res.arr = list
            }
            
          
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    
    static func addQuestion(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.QA.add.url(), params: params, success: { (rep) in
            let res:BaseResult = BaseResult.deserialize(from: rep)!
          
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
    static func getTearchList(params: [String : Any] = BaseParam.init().toJSON()!, success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        ZHttpTool.requestData(.post, urlString: CUSURL.QA.getTeacherList.url(), params: params, success: { (rep) in
            let res:BaseResult = BaseResult.deserialize(from: rep)!
            var arr = [ModelTeacher]()
            if res.success {
                for dict in rep["data"] as! [Dictionary<String, Any>]{
                    let m:ModelTeacher = ModelTeacher.deserialize(from: dict)!
                    arr.append(m)
                }
            }
          
            res.arr = arr

            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
    
}
