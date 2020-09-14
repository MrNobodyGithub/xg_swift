//
//  CourseEvaluateHeaderView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/4.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseEvaluateHeaderView: UIView {

    @IBOutlet weak var viewCon: UIView!
    // w :  30 + 38 + 51 + div
    // h : 15 +  17 + 11 + 11 + div   min 53 + 15
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        CommonTool.addCornerRadius_fast(sizeW: SCREEN_WIDTH - 30, sizeH: 145, layer: self.viewCon.layer, radius: 5, arr: [UIRectCorner.topLeft,UIRectCorner.topRight])
    }
}
