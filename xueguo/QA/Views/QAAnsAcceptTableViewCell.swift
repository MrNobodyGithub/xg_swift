//
//  QAAnsAcceptTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/28.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QAAnsAcceptTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labTeacher: UILabel!
    @IBOutlet weak var labAccept: UILabel!
    
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labText: UILabel!
    @IBOutlet weak var imgTeacher: UIImageView!
//        let w: CGFloat = SCREEN_WIDTH - 16 * 2 - 73 - 13
//        let h: CGFloat = 40+20 + 26 // 24
    // if h > 24 -> 86 + true else 110
    
    var model: ModelQaAnswer?{
        didSet{
            self.labText.text = model?.answer
            self.labTime.text = model?.createTime
            if (model?.updateTime.count)! > 0{
                self.labTime.text = model?.updateTime
            }
            self.labTeacher.text = model?.teacherName
            
            if model?.teacherSex == "1"{
                self.imgTeacher.image = UIImage.init(named: "teacher_sex_man")
            }else
            {
                self.imgTeacher.image = UIImage.init(named: "teacher_sex_female")
            }
             
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
        
        CommonTool.addCornerRadius(size: CGSize.init(width: 43, height: 20), layer: self.labAccept.layer, cornerSize: CGSize.init(width: 10, height: 10), arr: [UIRectCorner.topLeft,UIRectCorner.bottomRight])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
            
    }
    
}
