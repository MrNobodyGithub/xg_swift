//
//  CourseEvaluateTopView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/4.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseEvaluateTopView: UIView {

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
        let h :CGFloat = 80
        CommonTool.addGradientColo(self.viewCon.layer, CGSize.init(width: SCREEN_WIDTH, height: h), ["#8FC7FC","#5696F7"])
    }
}
