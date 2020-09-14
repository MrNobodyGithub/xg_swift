//
//  CourseDetailMidTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/3.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailMidTableViewCell: UITableViewCell {
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var labTitle: UILabel!
    
    @IBOutlet weak var labScore: UILabel! //占成绩：10
   
    @IBOutlet weak var labDetail: UILabel!  //获得成绩：10 评分：100
    let h:CGFloat = 87
    var model:ModelCourseAchievementVloList?{
        didSet{
            self.labTitle.text = model!.title
            self.labScore.text = "占成绩:" + model!.score
            self.labDetail.text = "获得成绩：" + model!.credit + "  " + "评分:" + model!.achievement
            self.ksettingBtnTitle(title: model!.status)
        }
    }
    var isLast:Bool?{
        didSet{
            if isLast == true{
                CommonTool.addCornerRadius(size: CGSize.init(width: SCREEN_WIDTH - 30, height: h), layer: self.viewCon.layer, cornerSize: CGSize.init(width: 10, height: 10), arr: [UIRectCorner.bottomLeft,UIRectCorner.bottomRight])
                self.viewLine.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewLine.isHidden = false
//        let arc = arc4random() % 4
//        if arc == 0{
//            self.btnStatus.setTitle("未开启", for: .normal)
//            self.btnStatus.setTitleColor(UIColor.colorWithHex(hexStr: "#C4C4C4"), for: .normal)
//            self.btnStatus.layer.borderWidth = 1
//            self.btnStatus.layer.borderColor = UIColor.colorWithHex(hexStr: "#C4C4C4").cgColor
//            self.btnStatus.backgroundColor = .white
//            self.btnStatus.layer.cornerRadius = 13.5
//        }else if arc == 1{
//
//            self.btnStatus.setTitle("已开启", for: .normal)
//            self.btnStatus.setTitleColor(.white, for: .normal)
//            self.btnStatus.backgroundColor = UIColor.colorWithHex(hexStr: "#EFA33F")
//            self.btnStatus.layer.cornerRadius = 13.5
//        }else if arc == 2{
//            self.btnStatus.setTitle("已完成", for: .normal)
//            self.btnStatus.setTitleColor(.white, for: .normal)
//            self.btnStatus.backgroundColor = UIColor.colorWithHex(hexStr: "#C4C4C4")
//            self.btnStatus.layer.cornerRadius = 13.5
//        }else
//        {
//            self.btnStatus.setTitle("已提交", for: .normal)
//            self.btnStatus.setTitleColor(.white, for: .normal)
//            self.btnStatus.backgroundColor = UIColor.colorWithHex(hexStr: "#C4C4C4")
//            self.btnStatus.layer.cornerRadius = 5
//        }
        
    }
    func ksettingBtnTitle(title:String){
        let arr:[String] = ["未发布","已发布","完成"]
        if title == arr[0]{
            self.kdynamicBtnStatus(title: title, type: 1)
        }else if title == arr[1]
        {
            self.kdynamicBtnStatus(title: title, type: 3)
        }else
        {
            self.kdynamicBtnStatus(title: title, type: 2)
        }
    }
    func kdynamicBtnStatus(title:String,type:NSInteger){
        if type == 1 {
            self.btnStatus.setTitle(title, for: .normal)
            self.btnStatus.setTitleColor(UIColor.colorWithHex(hexStr: "#C4C4C4"), for: .normal)
            self.btnStatus.layer.borderWidth = 1
            self.btnStatus.layer.borderColor = UIColor.colorWithHex(hexStr: "#C4C4C4").cgColor
            self.btnStatus.backgroundColor = .white
            self.btnStatus.layer.cornerRadius = 13.5
        }else if type == 2{
            self.btnStatus.setTitle(title, for: .normal)
            self.btnStatus.setTitleColor(.white, for: .normal)
            self.btnStatus.backgroundColor = UIColor.colorWithHex(hexStr: "#C4C4C4")
            self.btnStatus.layer.cornerRadius = 5
        }else if type == 3{
            self.btnStatus.layer.borderWidth = 0;
            self.btnStatus.setTitle(title, for: .normal)
            self.btnStatus.setTitleColor(.white, for: .normal)
            self.btnStatus.backgroundColor = UIColor.colorWithHex(hexStr: "#EFA33F")
            self.btnStatus.layer.cornerRadius = 13.5
        }else{
            self.btnStatus.setTitle(title, for: .normal)
            self.btnStatus.setTitleColor(.white, for: .normal)
            self.btnStatus.backgroundColor = UIColor.colorWithHex(hexStr: "#C4C4C4")
            self.btnStatus.layer.cornerRadius = 13.5
        }
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
    @IBAction func btnActionStatus(_ sender: UIButton) {
    }
}
