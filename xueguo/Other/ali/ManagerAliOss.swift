//
//  ManagerAliOss.swift
//  gbca
//
//  Created by CityMedia on 2019/7/30.
//  Copyright © 2019 q. All rights reserved.
//

import UIKit
import AliyunOSSiOS

class ManagerAliOss: NSObject {

    required override init() {
        
    }
    
    
    func putFile(data:Data,succ:@escaping BaseBlock){
        //0 init client
        let endPoint:String = ""//OSS_SERVER
        let accessKeyId:String = ""//OSS_ACCESSKEYID
        let secret:String = ""//OSS_ACCESSKEYSECRET
        let bucketName:String = ""//OSS_BUCKET
     
        // 自签名 鉴别方式
        let credential = OSSCustomSignerCredentialProvider.init { (sign, err) -> String? in
             let signTure = OSSUtil.calBase64Sha1(withData: sign, withSecret: secret)
            return "OSS " + accessKeyId + ":" + signTure!
        }
        let  client = OSSClient.init(endpoint: endPoint, credentialProvider: credential!)
 
        //1
        let put = OSSPutObjectRequest.init()
        put.bucketName = bucketName
        put.objectKey = "Other/" + self.getTimeStr() + "_" + self.getArcStr() + ".jpeg"
        put.uploadingData = data
        
        let address:String = put.objectKey
        
        let task =  client.putObject(put)
        
        task.continue({ (task) -> Any? in
            if task.error != nil {
                print("upload error")
                print(task.error! )
            }else
            {
                succ(address)
                
            }
            return nil
        }).waitUntilFinished()
    }
    func getTimeStr() -> String{
        let date:Date = Date.init()
        let timeInterval = date.timeIntervalSince1970
        var str = String(timeInterval)
        str = str.components(separatedBy: ".").first!
        return str
    }
    func getArcStr() -> String {
        return String(arc4random_uniform(100)+1)
    }
    
     
}
