//
//  CourseDetailMidHeaderView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/4.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit


protocol CourseDetailMidHeaderViewDelegate:NSObjectProtocol {
    func CourseDetailMidHeaderViewDelegateMessage(section:Int)
}

class CourseDetailMidHeaderView: UIView {
    
    
    
    //--------------------- in -------------------------------
    var section:Int?

    var dy_height:CGFloat?{
        didSet{
            CommonTool.addCornerRadius_fast(sizeW: SCREEN_WIDTH - 30, sizeH: dy_height!-10, layer: self.viewCon.layer, radius: 10, arr: [UIRectCorner.topRight,UIRectCorner.topLeft])
        }
    }
    @IBOutlet weak var btnNumber: UIButton!
    @IBOutlet weak var labSubTitle: UILabel!//占学分：3  获得绩点：0
    @IBOutlet weak var labDetail: UILabel!
    @IBOutlet weak var labTitle: UILabel!
    
    var model:ModelCourseAchievement?{
        didSet{
            self.btnNumber.setTitle(model!.count, for: .normal)
            self.labTitle.text = model?.code
            self.labSubTitle.text =  "占学分:" + model!.score
            self.labDetail.text = model?.info
            self.labDetail.numberOfLines = 0;
        }
    }
    
    var delegate: CourseDetailMidHeaderViewDelegate?
 
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
      
        
    }
    @IBAction func btnActionMessage(_ sender: Any) {
        if (delegate != nil) && delegate?.responds(to: Selector(("CourseDetailMidHeaderViewDelegateMessage:"))) != nil {
            delegate?.CourseDetailMidHeaderViewDelegateMessage(section: self.section ?? 0)
        }
         
    }
     
    
}
