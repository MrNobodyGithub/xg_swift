//
//  TEST.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/20.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import ObjectMapper

class Param: NSObject {
    var name:String?
    var age: Int?
    init(aname:String,aage:Int) {
        name = aname
        age = aage
    }
}
class ParamC: NSObject {
    var name:String{
        
        get{
            return "return value"
        }
    }
    
}
class ParamCSub: ParamC {
    var subname: String?

}
class ParanSub: Param {
    var subName: String?
    override init(aname: String, aage: Int) {
        super.init(aname: aname, aage: aage)
        
    }
    
}

class TEST: NSObject, Mappable {
    var name:String?
    var age: Int?
    required init?(map: Map) {
    }
    func mapping(map: Map){
        name <- map["name"]
        age <- map["age"]
    }
}
class TESTA: TEST  {
    var namea : String?
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        namea <- map["namea"]
    }
}





