//
//  CourseListProgressTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseListProgressTableViewCell: UITableViewCell {
    
    var model:ModelCourseList?{
        didSet{

            self.labTitle.text = model?.courseName
            self.labDetail.text = model?.courseCate
            self.labPoint.text = "课程成绩 " + model!.studentScore + "/100"
            self.labScore.text = "5"//model?.studentScore

//            课程状态  0-未开始  1-进行中 2-收集中 3-已经结束 4：测评中
            
//            let imgStr:String = "CourseTypeIng couseTypeOpen courseTypeFinish  CourseTypeTesting"
            let imgStr:String = "courseTypeIng courseTypeFinish cousreTypeOpen courseTypeTesting"
            var imageArr:[String] = imgStr.components(separatedBy: " ")
            if model?.status != "0"{
                let index = Int(model!.status)
                imgStatus.image = UIImage.init(named: imageArr[index! - 1])
            }
            if model?.isReply == "1" {
                self.labNewReply.isHighlighted = false;
            }else
            {
                self.labNewReply.isHighlighted = true;
            }
            
            
            let all:Float = (model?.subtasksCount.toFloat())! + (model?.unopenedCount.toFloat())!
            let orangeCount:Float = (model?.completedCount.toFloat())! +  (model?.incompleteCount.toFloat())!
            let greenCount = model?.completedCount.toFloat()
            
            
            
            let arcPro  = Float(greenCount! / all)
            let arcOrange = Float(orangeCount / all);
            
            let proW:CFloat = CFloat(SCREEN_WIDTH - 155)
            self.layoutProgressR.constant = CGFloat((1 - (arcPro )) * proW)
            self.layoutProgressOrangeR.constant = CGFloat((1 - arcOrange) * proW)
            
            self.labPro.text =  "完成度" + String(Int(arcPro * 100)) + "%"
            
        }
    }
    
   
    
// courseTypeFinish CourseTypeIng couseTypeOpen CourseTypeTesting
    //img name up
    // 16 +16+ 78 + 13 + 16 + 16 = 155
    @IBOutlet weak var layoutProgressOrangeR: NSLayoutConstraint!
    @IBOutlet weak var layoutProgressR: NSLayoutConstraint!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var viewCon: UIView!
    
    @IBOutlet weak var labNewReply: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var labScore: UILabel!
    @IBOutlet weak var labPro: UILabel!
    @IBOutlet weak var labPoint: UILabel!
    @IBOutlet weak var labDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        self.labNewReply.layer.borderWidth = 1
        self.labNewReply.layer.borderColor = UIColor.colorWithHex(hexStr: "#F09A88").cgColor
        self.labNewReply.layer.cornerRadius = 2
        self.labNewReply.layer.masksToBounds = true
    }
    func setupViews(){
        CommonTool.addShadowCorner(viewCon.layer)
        
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
}
