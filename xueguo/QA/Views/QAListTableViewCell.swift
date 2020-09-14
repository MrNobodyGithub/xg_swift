//
//  QAListTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QAListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var labUser: UILabel!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labQuestion: UILabel!
    var model: ModelQaList?{
        didSet{
            self.labQuestion?.text = model?.question
            self.labUser.text = model?.teacherName
            self.labTime.text = model?.createTime
            
            let status:Int = model!.status // 012  未答 已答  已采纳
            let unReadCount:Int = model!.unReadCount
            
//            if model.sex {
//            let arcsex  = CommonTool.cusRandBool()
            
            if model?.teacherSex == "1"{
                self.imgUser.image = UIImage.init(named: "teacher_sex_man")
            }else
            {
                self.imgUser.image = UIImage.init(named: "teacher_sex_female")
            }
//            } 
            
            //FIXME:-------后台暂未返回unReadCount字符 后续更新-------
//            "unReadCount": 0，这个字段不为0，代表 有回复 未读。未读数为0时，应该显示这个 已答
//            所以我的理解是 unReadCount 不为0，显示 “有回复”，并显示条数；如果unReadCount为0，并且status是已答，那么就显示已答。应该是这样理解吧？
            
            if status == 1{
                if unReadCount > 0 {
                    self.labStatus.text = "有回复"
                    self.labStatus.textColor = UIColor.colorWithHex(hexStr: "F09A88")
                    self.imgStatus.image = UIImage.init(named: "reply")
                }else{
                    self.labStatus.text = ""
                    self.labStatus.textColor = UIColor.colorWithHex(hexStr: "F09A88")
                    self.imgStatus.image = UIImage.init()
                }
               
            }else if status == 2{
                self.labStatus.text = "已采纳"
                self.labStatus.textColor = UIColor.colorWithHex(hexStr: "5CCA7C")
                self.imgStatus.image = UIImage.init(named: "accept")
            }else
            {
                self.labStatus.text = ""
                self.labStatus.textColor = UIColor.colorWithHex(hexStr: "F09A88")
                self.imgStatus.image = UIImage.init()
            }
        }
    }
    @IBOutlet weak var viewCon: UIView!
    //accept reply
    //#5CCA7C  #F09A88
    //已采纳   有回复
   
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var labStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
//        let arc: Int = Int(arc4random() % 2)
//        if arc == 0 {
//            self.labStatus.text = "已采纳"
//            self.labStatus.textColor = UIColor.colorWithHex(hexStr: "5CCA7C")
//            self.imgStatus.image = UIImage.init(named: "accept")
//        }else
//        {
//            self.labStatus.text = "有回复"
//            self.labStatus.textColor = UIColor.colorWithHex(hexStr: "F09A88")
//            self.imgStatus.image = UIImage.init(named: "reply")
//        }
        
    }
    func setupViews(){
        addCorner()
    }
    func addCorner() -> Void {
        viewCon.layer.cornerRadius = 10
        viewCon.backgroundColor = .white
        viewCon.layer.shadowColor = UIColor.lightGray.cgColor
        viewCon.layer.borderWidth = 0.1
        viewCon.layer.borderColor = viewCon.layer.shadowColor
        viewCon.layer.shadowOpacity = 0.4
        viewCon.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
            
    }
    
}
