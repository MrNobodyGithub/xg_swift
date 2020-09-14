//
//  CourseDetailStructSectionView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/31.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailStructSectionView: UIView {

    @IBOutlet weak var imgStruct: UIImageView!
    @IBOutlet weak var labDetail: UILabel! //占学分：5       占成绩：80
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var viewCon: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        CommonTool.addGradientColo(self.viewCon.layer, CGSize.init(width: SCREEN_WIDTH-30, height: 80), ["#8FC7FC","#5696F7"])
        
    } 

}
