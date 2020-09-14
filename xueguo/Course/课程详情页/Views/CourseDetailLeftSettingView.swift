//
//  CourseDetailLeftSettingView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailLeftSettingView: UIView {

    var model:ModelCourseDtail?{
        didSet{
            self.labTopL.text = model?.credits
            self.labDownL.text = model?.cloCount
            self.labDownR.text = model?.evaluateCount
//            self.labTopR.text = model!.courseScore
        }
    }
    
    @IBOutlet weak var labTopL: UILabel!
    @IBOutlet weak var labTopR: UILabel!
    @IBOutlet weak var labDownL: UILabel!
    @IBOutlet weak var labDownR: UILabel!
    
    
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
}
