//
//  CourseDetailMidMessageViewAnswerTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/9/7.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailMidMessageViewAnswerTableViewCell: UITableViewCell {

    
    
    //--------------------- in -------------------------------
    
    @IBOutlet weak var labTime: UILabel!
    
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    //--------------------- out -------------------------------
    var height:CGFloat?{
        didSet{
            CommonTool.addCornerRadius_fast(sizeW: 171, sizeH: height! - CGFloat(34), layer: self.viewCon.layer, radius: 8, arr: [UIRectCorner.topLeft,UIRectCorner.topRight,UIRectCorner.bottomRight])
        }
    }
    var model:ModelCloMeeeageList_answer?{
        didSet{
            self.labTime.text = model!.createTime
            self.labTitle.text = model?.answer
            if model!.studentAvatar.count != 0 {
                self.imgIcon.z_imgUrl(urlStr: model!.studentAvatar)
            }
        }
    }
    
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
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
}
