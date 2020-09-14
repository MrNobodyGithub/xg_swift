//
//  CourseDetailStructCellViewSec.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/31.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailStructCellViewSec: UIView {
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var labDetial: UILabel! //占学分：3  占成绩：70
    @IBOutlet weak var labTitle: UILabel! 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        
    }


}
