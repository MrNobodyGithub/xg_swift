//
//  ResultMe.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/22.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import HandyJSON



class ResultMe: NSObject {

}
 
class ModelCollection_res:Z_HandyJSON {
    var srcNotes:String = ""
    var srcLength:String = ""
    var srcFormat:String = ""
    var id:String = ""
    var resources:String = ""
    var userId:String = ""
    var createTime:String = ""
    var deleteTime:String = ""
    var likes:String = ""
    
    var views:String = ""
    var title:String = ""
    var url:String = ""
    var srcSize:String = ""
}
class ModelCollection:Z_HandyJSON {
    var resources :String = ""
    var userId = ""
    var createTime = ""
    var deleteTime = ""
    var id = ""
    var resourceSrc:ModelCollection_res = ModelCollection_res.init()
    
}
class ModelPosition: Z_HandyJSON {
    var id:String = ""
    var positionCode:String = ""
    var positionName:String = ""
    var parentCode:String = ""
    var createUser:String = ""
    var createTime:String = ""
    var updateUser:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""

}
class ModelIndustry: Z_HandyJSON {
    var level:NSInteger = 0 // 自定义级别
    var id:String = ""
    var industryCode:String = ""
    var industryName:String = ""
    var parentCode:String = ""
    var createUser:String = ""
    var createTime:String = ""
    var updateUser:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""

}
class ModelJobList: Z_HandyJSON {
    var id:String = ""
    var studentId:String = ""
    var companyName:String = ""
    var industry:String = ""
    var workPlace:String = ""
    var address:String = ""
    var position:String = ""
    var salary:String = ""
    var jobDuties:String = ""
    var remark:String = ""
    var joinDate:String = ""
    var leaveDate:String = ""
    var createUser:String = ""
    var updateUser:String = ""
    var createTime:String = ""
    var updateTime:String = ""
    var deleteTime:String = ""
    
}

class ModelUser: NSObject, HandyJSON, NSCoding{
//    var id : String = ""
//    var mobile:String = ""
//    var loginPassword:String = ""
//    var token:String = ""
//    var majorId:String = ""
    
    var academyId:String = ""
    var academyName:String = ""
    var address:String = ""
    var area:String = ""
    var avatar:String = ""
    var birthday:String = ""
    var cardID:String = ""
    var city:String = ""
    var classId:String = ""
    var classNo:String = ""
    var classNumber:String = ""
    var collegeId:String = ""
    var collegeName:String = ""
    var createTime:String = ""
    var createUser:String = ""
    var deleteTime:String = ""
    var email:String = ""
    var enrolmentTime:String = ""
    var grade:String = ""
    var graduationTime:String = ""
    var id:String = ""
    var isReading:String = ""
    var loginPassword:String = ""
    var majorId:String = ""
    var majorName:String = ""
    var mobile:String = ""
    var politics:String = ""
    var province:String = ""
    var qqUnionId:String = ""
    var sex:String = ""
    var sinaUnionId:String = ""
    var status:String = "" // 2 4 通过 0 1 3   待完善 待审核 审核拒绝
    var studentName:String = ""
    var studentNo:String = ""
    var token:String = ""
    var updateTime:String = ""
    var updateUser:String = ""
    var wxOpenId:String = ""
    var wxUnionId:String = ""
    var yearSystem:String = ""

    
    
    
    required override init() {
        super.init()
        
    }
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(mobile, forKey: "mobile")
//        aCoder.encode(loginPassword, forKey: "loginPassword")
//        aCoder.encode(token, forKey: "token")
//        aCoder.encode(majorId, forKey: "majorId")
//        aCoder.encode(id, forKey: "id")
        
        aCoder.encode(academyId, forKey:"academyId")
        aCoder.encode(academyName, forKey:"academyName")
        aCoder.encode(address, forKey:"address")
        aCoder.encode(area, forKey:"area")
        aCoder.encode(avatar, forKey:"avatar")
        aCoder.encode(birthday, forKey:"birthday")
        aCoder.encode(cardID, forKey:"cardID")
        aCoder.encode(city, forKey:"city")
        aCoder.encode(classId, forKey:"classId")
        aCoder.encode(classNo, forKey:"classNo")
        aCoder.encode(classNumber, forKey:"classNumber")
        aCoder.encode(collegeId, forKey:"collegeId")
        aCoder.encode(collegeName, forKey:"collegeName")
        aCoder.encode(createTime, forKey:"createTime")
        aCoder.encode(createUser, forKey:"createUser")
        aCoder.encode(deleteTime, forKey:"deleteTime")
        aCoder.encode(email, forKey:"email")
        aCoder.encode(enrolmentTime, forKey:"enrolmentTime")
        aCoder.encode(grade, forKey:"grade")
        aCoder.encode(graduationTime, forKey:"graduationTime")
        aCoder.encode(id, forKey:"id")
        aCoder.encode(isReading, forKey:"isReading")
        aCoder.encode(loginPassword, forKey:"loginPassword")
        aCoder.encode(majorId, forKey:"majorId")
        aCoder.encode(majorName, forKey:"majorName")
        aCoder.encode(mobile, forKey:"mobile")
        aCoder.encode(politics, forKey:"politics")
        aCoder.encode(province, forKey:"province")
        aCoder.encode(qqUnionId, forKey:"qqUnionId")
        aCoder.encode(sex, forKey:"sex")
        aCoder.encode(sinaUnionId, forKey:"sinaUnionId")
        aCoder.encode(status, forKey:"status")
        aCoder.encode(studentName, forKey:"studentName")
        aCoder.encode(studentNo, forKey:"studentNo")
        aCoder.encode(token, forKey:"token")
        aCoder.encode(updateTime, forKey:"updateTime")
        aCoder.encode(updateUser, forKey:"updateUser")
        aCoder.encode(wxOpenId, forKey:"wxOpenId")
        aCoder.encode(wxUnionId, forKey:"wxUnionId")
        aCoder.encode(yearSystem, forKey:"yearSystem")
        

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
//        mobile = aDecoder.decodeObject(forKey: "mobile") as! String
//        loginPassword = (aDecoder.decodeObject(forKey: "loginPassword") as! String)
//        token = aDecoder.decodeObject(forKey: "token") as! String
//        majorId = aDecoder.decodeObject(forKey: "majorId") as! String
//        id = aDecoder.decodeObject(forKey: "id") as! String
        
        academyId = aDecoder.decodeObject(forKey: "academyId") as! String
        academyName = aDecoder.decodeObject(forKey: "academyName") as! String
        address = aDecoder.decodeObject(forKey: "address") as! String
        area = aDecoder.decodeObject(forKey: "area") as! String
        avatar = aDecoder.decodeObject(forKey: "avatar") as! String
        birthday = aDecoder.decodeObject(forKey: "birthday") as! String
        cardID = aDecoder.decodeObject(forKey: "cardID") as! String
        city = aDecoder.decodeObject(forKey: "city") as! String
        classId = aDecoder.decodeObject(forKey: "classId") as! String
        classNo = aDecoder.decodeObject(forKey: "classNo") as! String
        classNumber = aDecoder.decodeObject(forKey: "classNumber") as! String
        collegeId = aDecoder.decodeObject(forKey: "collegeId") as! String
        collegeName = aDecoder.decodeObject(forKey: "collegeName") as! String
        createTime = aDecoder.decodeObject(forKey: "createTime") as! String
        createUser = aDecoder.decodeObject(forKey: "createUser") as! String
        deleteTime = aDecoder.decodeObject(forKey: "deleteTime") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        enrolmentTime = aDecoder.decodeObject(forKey: "enrolmentTime") as! String
        grade = aDecoder.decodeObject(forKey: "grade") as! String
        graduationTime = aDecoder.decodeObject(forKey: "graduationTime") as! String
        id = aDecoder.decodeObject(forKey: "id") as! String
        isReading = aDecoder.decodeObject(forKey: "isReading") as! String
        loginPassword = aDecoder.decodeObject(forKey: "loginPassword") as! String
        majorId = aDecoder.decodeObject(forKey: "majorId") as! String
        majorName = aDecoder.decodeObject(forKey: "majorName") as! String
        mobile = aDecoder.decodeObject(forKey: "mobile") as! String
        politics = aDecoder.decodeObject(forKey: "politics") as! String
        province = aDecoder.decodeObject(forKey: "province") as! String
        qqUnionId = aDecoder.decodeObject(forKey: "qqUnionId") as! String
        sex = aDecoder.decodeObject(forKey: "sex") as! String
        sinaUnionId = aDecoder.decodeObject(forKey: "sinaUnionId") as! String
        status = aDecoder.decodeObject(forKey: "status") as! String
        studentName = aDecoder.decodeObject(forKey: "studentName") as! String
        studentNo = aDecoder.decodeObject(forKey: "studentNo") as! String
        token = aDecoder.decodeObject(forKey: "token") as! String
        updateTime = aDecoder.decodeObject(forKey: "updateTime") as! String
        updateUser = aDecoder.decodeObject(forKey: "updateUser") as! String
        wxOpenId = aDecoder.decodeObject(forKey: "wxOpenId") as! String
        wxUnionId = aDecoder.decodeObject(forKey: "wxUnionId") as! String
        yearSystem = aDecoder.decodeObject(forKey: "yearSystem") as! String

    }
    
    
    
    /**
     academyId = "<null>";
     academyName = "<null>";
     address = "<null>";
     area = "<null>";
     avatar = "<null>";
     birthday = "<null>";
     cardID = "<null>";
     city = "<null>";
     classId = "<null>";
     classNo = "<null>";
     classNumber = "<null>";
     collegeId = "<null>";
     collegeName = "<null>";
     createTime = "<null>";
     createUser = "<null>";
     deleteTime = "<null>";
     email = "<null>";
     enrolmentTime = "<null>";
     grade = "<null>";
     graduationTime = "<null>";
     id = 3;
     isReading = "<null>";
     loginPassword = 40bd001563085fc35165329ea1ff5c5ecbdbbeef;
     majorId = "<null>";
     majorName = "<null>";
     mobile = 13141384483;
     politics = "<null>";
     province = "<null>";
     qqUnionId = "<null>";
     sex = "<null>";
     sinaUnionId = "<null>";
     status = 0;
     studentName = "<null>";
     studentNo = "<null>";
     token = 2b5dbb9b3efc42e8b864706623c27dec;
     updateTime = "<null>";
     updateUser = "<null>";
     wxOpenId = "<null>";
     wxUnionId = "<null>";
     yearSystem = "<null>";
     */
    
    
    
}

