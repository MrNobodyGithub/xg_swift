//
//  ParamQA.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/29.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit


class ParamQA: NSObject {

}
class ParamQaAccept:BaseParam{
    var answerId: Int?
    var questionId:Int?
}
class ParamQaRepeal:BaseParam{
     var questionId:Int?
}
class ParamQaAskAgain: BaseParam {
    var type:Int = 1 //ype  0:回答  1：追问，学生端是追问
    var questionId:Int?
    var answer:String?
    var teacherId:Int?
}
class ParamQaDetail: BaseParam {
    var questionId : String?
}
class ParamQaList: BaseParamPage {
    var question:String?
    var status: Int? //0:未答 1：已答 2：已采纳 不传是全部
    
}
class ParamQaAdd: BaseParam {
    
//    var studentId :String?
    var teacherId:String?
    var question:String?
}
