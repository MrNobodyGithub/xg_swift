//
//  CourseDetailLeftBaseInfo.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailLeftBaseInfo: UIView {
    //--------------------属性--------------------------------
    
    @IBOutlet weak var labTheoryTime: UILabel!
    
    @IBOutlet weak var labPracticeTime: UILabel!
    @IBOutlet weak var labCourseCode: UILabel!
    @IBOutlet weak var labCourseType: UILabel!
    
    @IBOutlet weak var labLevel: UILabel!
    @IBOutlet weak var labYear: UILabel!
    @IBOutlet weak var labSemester: UILabel!
    
    @IBOutlet weak var viewBefore: UIView!
    @IBOutlet weak var viewTogether: UIView!
    @IBOutlet weak var viewAfter: UIView!
    
    @IBOutlet weak var layoutBefore: NSLayoutConstraint!
    @IBOutlet weak var layoutAfter: NSLayoutConstraint!
    @IBOutlet weak var layoutTogether: NSLayoutConstraint!
    // scwidth -  15 * 2 - 24 - 68 - 5 * 2
    // scwidth - 132
    // h 20
    // difLine 10
    //--------------------------- -------------------------
    
    
    var model:ModelCourseDtail?{
        didSet{
//            self.labCourseTime.text = model?.totalCoursePeriod
            self.labTheoryTime.text = "理论学时" + "0"
            self.labPracticeTime.text = "实践学时" + model!.totalCoursePeriod
            self.labCourseCode.text = model?.courseCode
            self.labCourseType.text = model?.courseCate
//            self.labCourseNature.text = model?.courseType
            self.labLevel.text = model?.courseRank
//            self.labYear.text = model!.startYear + "-" + model!.endYear

            self.labSemester.text = self.kdealSemester(str: model!.startSemester)
//            model?.beforeCourse
//             model?.togetherCourse
//            model?.afterCourse
            
            // 字符串转数组
//            model?.beforeCourse
            
            let typeArr:[String] = ["[","]","\"","\\"];
            var str_A = model?.beforeCourse ?? ""
            var str_b = model!.togetherCourse
            var str_c = model!.afterCourse
            for type in typeArr{
                str_A = str_A.replacingOccurrences(of: type, with: "")
                str_b = str_b.replacingOccurrences(of: type, with: "")
                str_c = str_c.replacingOccurrences(of: type, with: "")
            }
            
            let arrBefore:[String] =  str_A.components(separatedBy: ",")
            let arrTogether:[String] = str_b.components(separatedBy: ",")
            let arrAfter:[String] = str_c.components(separatedBy: ",")
            
            // 设置高度
            self.layoutBefore.constant = self.kgetHeightForBaseInfoSingle(arr: arrBefore)
            self.layoutTogether.constant = self.kgetHeightForBaseInfoSingle(arr: arrTogether)
            self.layoutAfter.constant =  self.kgetHeightForBaseInfoSingle(arr: arrAfter)
            //添加到页面
            self.addSubViewCourse(arr: arrBefore, superView: self.viewBefore)
            self.addSubViewCourse(arr: arrTogether, superView: self.viewTogether)
            self.addSubViewCourse(arr: arrAfter, superView: self.viewAfter)
        }
    }
    //----------------------------------------------------
    // 412 + 13 = 425
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        
    }
    
    func addSubViewCourse(arr:[String],superView:UIView){
        let font:UIFont = UIFont.systemFont(ofSize: 12)
        let difH :CGFloat = 10
        let difW:CGFloat = 10
        let difAddW:CGFloat = 16
        let allW:CGFloat = SCREEN_WIDTH - 132.0
        var x :CGFloat = 0
        var y:CGFloat = 5
        let h:CGFloat = 20
      
        for (index,value) in arr.enumerated() {
            if value.count == 0 {
                break;
            }
            
            let w :CGFloat = CommonTool.getStrWidth(str:value, fontsize: 12, height:h+difH) + difAddW
         
            if index != 0 {
                let newx = x + w + difW
                if newx > allW{
                    x = 0
                    y += 30
                }
            }
            
            let lab:UILabel = UILabel.init(frame: CGRect.init(x: x, y: y, width: w, height: h))
            lab.font = font
            
            x += (w + difW)
           
            
            
            lab.textAlignment = .center
            superView.addSubview(lab)
            lab.text = value
            lab.backgroundColor = UIColor.colorWithHex(hexStr: "#C4C4C4")
            lab.textColor = .white
            lab.layer.cornerRadius = 3
            lab.layer.masksToBounds = true
        }
    }
    
    func kdealSemester(str:String) -> String{
        if str == "1"{
            return "第一学期"
        }else if str == "2"{
            return "第二学期"
            
        }else if str == "3"{
            return "第三学期"
            
        }else if str == "4"{
            return "第四学期"
        }
        return ""
    }
    func kgetHeightForBaseInfoSingle(arr:[String]) -> CGFloat{
        let font:UIFont = UIFont.systemFont(ofSize: 12)
        let difH :CGFloat = 10
        let difW:CGFloat = 10
        let difAddW:CGFloat = 16
        let allW:CGFloat = SCREEN_WIDTH - 132.0
        var x :CGFloat = 0
        var y:CGFloat = 5
        let h:CGFloat = 20
        var number :CGFloat = 1
        for ( _ ,value) in arr.enumerated() {
            let w :CGFloat = CommonTool.getStrWidth(str:value, fontsize: 12, height:h+difH) + difAddW
            
            x += (w + difW)
            if x > allW {
                x = 0
                y += 30
                number += 1
            }
            
            let lab:UILabel = UILabel.init(frame: CGRect.init(x: x, y: y, width: w, height: h))
            lab.font = font
            lab.textAlignment = .center
        }
        return number * CGFloat(30)
    }
    
}
