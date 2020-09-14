//
//  OtherTool.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/3.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class OtherTool: NSObject {

    static func getAppVersion(params: [String : Any], success:@escaping (_ result: BaseResult) -> (), fail:@escaping(_ error: Error) -> () ){
        
        ZHttpTool.requestData(.post, urlString: CUSURL.Login.getVcode.url(), params: params, success: { (rep) in
            let res = BaseResult.deserialize(from: rep)!
            if res.success {
                
            }
            success(res)
        }, fail: { (err) in
            fail(err)
        });
    }
}


/**
 *根据某一地址下载文件 (含 进度展示 默认下载caches文件夹)
 */ 
class ZDownLoadTool:NSObject{
    
    
    static func downLoadWithUrl_short(url:String,fileDirectionName:String = "file",progress:@escaping(_ progress:Double)-> (),success:@escaping(_ path:String) -> ()){
        let newFileName   = url.components(separatedBy: "/").last!
        ZHttpTool.download(url, fileDirectionName, newFileName, progress: { (pro) in
            progress(pro)
        }, success: { path in
            success(path)
        })
    }
    static func downLoadWithUrl(url:String,fileDirectionName:String = "file",fileName:String,progress:@escaping(_ progress:Double)-> (),success:@escaping(_ succ:URL) -> (), fail:@escaping(_ error:Error) -> ()){
        var newFileName = fileName
        if newFileName.count == 0 {
            newFileName = url.components(separatedBy: "/").last!
        }
        ZHttpTool.download(url, fileDirectionName, newFileName, progress: { (pro) in
            progress(pro)
        }, success: {(path) in
            success(URL.init(fileURLWithPath: path))
        })
        
    }
}
