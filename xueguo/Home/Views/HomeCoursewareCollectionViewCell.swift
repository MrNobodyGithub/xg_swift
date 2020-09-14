//
//  HomeCoursewareCollectionViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HomeCoursewareCollectionViewCell: UICollectionViewCell {
    var indexP : IndexPath?{
        didSet{
            let newIndexP = indexP
            
            let number = newIndexP!.row % 5
            print(number)
            let fileName = "file_type_" + String(number)
            
            self.imgBg.image = UIImage.init(named: fileName)
        }
    }
    var model:ModelLearnRes?{
        didSet{
            self.labTitle.text = model!.courseName
            self.labNumber.text = "资源:" + model!.count;
        }
    }
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        imgBg.layer.cornerRadius = 10
        imgBg.layer.masksToBounds = true
    } 
}
