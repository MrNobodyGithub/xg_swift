//
//  CourseDetailMidTeacherViewCollectionViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/9/22.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailMidTeacherViewCollectionViewCell: UICollectionViewCell {

    
    var model:ModelTeacher?{
        didSet{
            if model?.isReply == "1" {
                self.imgCircleRed.isHidden = false;
            }else{
                self.imgCircleRed.isHidden = true;
            }
            self.labTitle.text = model?.name
            if model!.avatar.count > 0 {
                self.img.z_imgUrl(urlStr: model!.avatar)
            }else
            {
                if model?.sex == "1" {
                    self.img.image = UIImage.init(named: "teacher_sex_man")
                }else
                {
                    self.img.image = UIImage.init(named: "teacher_sex_female")
                }
            }
        }
    }
    //--------------------- pro -------------------------------
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var imgCircleRed: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib() 
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        self.imgCircleRed.layer.cornerRadius = 5;
        CommonTool.addGradientColo(self.imgCircleRed.layer, CGSize.init(width: 10, height: 10), ["#F0928B","#DD5953"])
        
    }
    func setupViews(){
        
    }
    
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
//    override func setSelected(_ selected: Bool, animated: Bool) {}
}
