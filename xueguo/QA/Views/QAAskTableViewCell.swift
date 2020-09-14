//
//  QAAskTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QAAskTableViewCell: UITableViewCell {

    
    
//    let w :CGFloat = SCREEN_WIDTH - 16*2 - 73 - 13
//    let h :CGFloat = 74 + 36
    // > 36 -> 74 + labH else 110
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labPerson: UILabel! //被提问人：刘德华
    @IBOutlet weak var labText: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var viewCon: UIView!
    var modelAnswer:ModelQaAnswer?{
        didSet{
            
            self.labText.text = modelAnswer?.answer
            self.labTime.text = modelAnswer?.createTime
            if (modelAnswer?.updateTime.count)! > 0 {
                self.labTime.text = modelAnswer?.updateTime
            }
            self.labPerson.text = "被提问人：" + modelAnswer!.teacherName
            
            if model?.studentSex == "1" {
                  self.imgIcon.image = UIImage.init(named: "sex_man")
              }else{
                  self.imgIcon.image = UIImage.init(named: "sex_female")
              }
        }
    }
    var model: ModelQaDetail?{
        didSet{
            self.labText.text = model?.question
            self.labTime.text = model?.createTime
            if (model?.updateTime.count)! > 0 {
                self.labTime.text = model?.updateTime
            }
            self.labPerson.text = "被提问人：" + model!.teacherName
            
            if model?.studentSex == "1" {
                self.imgIcon.image = UIImage.init(named: "sex_man")
            }else{
                self.imgIcon.image = UIImage.init(named: "sex_female")
            }
            
        }
    }
    var conH:CGFloat? {
        didSet{
            self.viewCon.layer.cornerRadius = 5
            self.viewCon.layer.masksToBounds = true
//            CommonTool.addCornerRadius(size: CGSize.init(width: SCREEN_WIDTH - 32, height: conH!), layer: self.viewCon.layer, cornerSize: CGSize.init(width: 5, height: 5), arr: UIRectCorner.allCorners)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
    }
    func setupViews(){
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
}
