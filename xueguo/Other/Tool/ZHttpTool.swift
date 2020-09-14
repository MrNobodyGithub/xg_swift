//
//  ZHttpTool.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON
import ObjectMapper
import MBProgressHUD
enum MethodType {
    case get
    case post
}
class ZCachesTool:NSObject{
    // 1 本地查询 暂时 用 1
    // 2 sqlite 存储 查询
    
    class func fileExist(dir:String = "file",fileName:String) -> Bool{
        
        let NewFileName:String  = fileName
        var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        cachePath.append("/")
        cachePath.append(dir)
        cachePath.append("/")
        cachePath.append(NewFileName)
        
        let manager = FileManager.default
        let isExist = manager.fileExists(atPath: cachePath)
        return isExist
    }
    
}

class ZHttpTool: NSObject  {
    class func postData (urlString:String ,params: [String : Any], success:@escaping(_ result : [String : Any]) -> (), fail:@escaping(_ result : Error) -> (),isHiddenHud: Bool? = false) {
        self .requestDataAll(MethodType.post, urlString: urlString, params: params , success: success, fail: fail, isHiddenHud: isHiddenHud ?? false)
        
    }
    
    class func getData (urlString:String ,params: [String : Any], success:@escaping(_ result : [String : Any]) -> (), fail:@escaping(_ result : Error) -> (),isHiddenHud: Bool? = false) {
        self .requestDataAll(MethodType.get, urlString: urlString, params: params , success: success, fail: fail, isHiddenHud: isHiddenHud ?? false)
    }
    
    
    class func requestData (_ type:MethodType, urlString:String ,params: [String : Any], success:@escaping(_ result : [String : Any]) -> (), fail:@escaping(_ result : Error) -> (),isHiddenHud: Bool? = false) {
        self.requestDataAll(type, urlString: urlString, params: params , success: success, fail: fail, isHiddenHud: isHiddenHud ?? false)
    }
   
 
    class func requestDataAll(_ type:MethodType, urlString:String ,params: [String : Any]? = nil, success:@escaping(_ result : [String : Any]) -> (), fail:@escaping(_ result : Error) -> (),isHiddenHud: Bool? = false) {
        
//        let window = UIApplication.shared.keyWindow
//        if isHiddenHud ?? false{
//        }else{
//            MBProgressHUD.zshow(view: window)
//        }
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let headers = ["userId":CommonTool.getUserId(),"collegeId":CommonTool.getCollegeId()]
   
        var urlType = ""
        switch type {
        case .get:
            urlType = "get"
        default:
             urlType = "post"
        }
        print("--- ---------------" + urlType+"----url------------------ ---");
        print(urlString)
        print("---  ------------------params------------------ ---");
        print(params as Any)
        print("---  ------------------headers------------------ ---");
        print(headers as Any)
        Alamofire.request(urlString, method: method, parameters: params,encoding: JSONEncoding.default,headers: headers).responseJSON { (response) in
 
            let result = response.result.value
            if response.result.isSuccess{
                print("---  -res- ---");
                print(result as Any)
                success(result as! [String : Any])
            }else{
                fail(response.result.error!)
                
            }
        }
    }
    // 上传 ()
    class func upload(params: [String : String],_ url:String, arr:[FileFormData], success:@escaping(_ result : [String : Any]) -> (), fail:@escaping(_ result : Error) -> () ){
        
        Alamofire.upload(multipartFormData: { (formData: MultipartFormData) in
            for fdata in arr{
                formData.append(fdata.data! , withName: fdata.name, fileName: fdata.fileName, mimeType: fdata.mimeType)
            }
            for (key, value) in params {
                formData.append(value.data(using: .utf8)!, withName: key)
            }
    }, to: URL.init(string: url)!) { (encodingResult) in
        switch encodingResult{
        case .success( _ , _ , _):
            print("suc")
            success(["code":"0"])
        case .failure( _):
            print("fail")
            let err: Error = BaseError.init("cus_error")
            print(err.localizedDescription) // cus_error
            fail(err)
        }
        }
    }
    
     
    //下载
    class func download(_ url:String,_ dir:String = "file",_ fileName:String, progress:@escaping(_ result : Double) -> (),success:@escaping(_ path:String)-> ()) {
        
        var fileUrl = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        fileUrl?.append("/")
        fileUrl?.append(dir)
        
        var isExist:ObjCBool = ObjCBool(false)
        let manager = FileManager.default
        if !manager.fileExists(atPath: fileUrl!, isDirectory: &isExist) {
            try? manager.createDirectory(atPath: fileUrl!, withIntermediateDirectories: true, attributes: nil)
        }
        
        
        fileUrl?.append("/")
        fileUrl?.append(fileName)
        if manager.fileExists(atPath: fileUrl!) {
           try? manager.removeItem(atPath: fileUrl!)
        }
       
    
        let fileURL = URL.init(fileURLWithPath: fileUrl!)
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
        }
        
        
        let strUtf8 = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
//        let strUtf8 = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        let URLA = URL.init(string: strUtf8!)!

        print("downing")
        print(strUtf8)
        print(fileUrl)
        Alamofire.download(URLA, to: destination)
            .downloadProgress(closure: { (pro) in
             print(pro.fractionCompleted)
            progress(pro.fractionCompleted)
                
            }).validate { request, response, temporaryURL, destinationURL in
                // Custom evaluation closure now includes file URLs (allows you to parse out error messages if necessary)
                success(destinationURL?.absoluteString ?? "")
                return .success
            }.responseData { response in
                debugPrint(response)
                print(response.temporaryURL)
                print(response.destinationURL?.absoluteString)
                
        }
    }
    
   
    
}

