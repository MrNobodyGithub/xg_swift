//
//  BaseModel.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import HandyJSON

class BaseParamPage: BaseParam {
    var pageIndex: Int?
    var pageSize: Int = 10
    required init() {
    }
}
class BaseParam: HandyJSON {
    
    var studentId :String?
    var userId:String?
    required init() {
    }
    
}
class FileFormData: NSObject {
    var data: Data?
    var name: String = ""       //参数名
    var fileName:String = ""      //文件名
    var mimeType:String = ""      //文件类型 = ""
}
class BaseResult: HandyJSON {
    
    var errorCode: Int = -1 // 0 成功
    var data: Any?
    var message: String = ""
    var total:Int = 0
    var success:Bool{
        get{
            if errorCode == 0 {
                return true
            }
            return false
        }
    }
    var arr:Array =  [Any]()
    
    var dict = Dictionary<String, Any>()
    required init() {
    }
    //    required init?(map: Map) {
    //
    //    }
    //
    //    func mapping(map: Map) {
    //        code <- map["code"]
    //        data <- map["data"]
    //    }
}

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.colorWithHex(hexStr: "F8F9FA")
    }
}

