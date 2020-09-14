//
//  CourseDetailLeftMyGradeView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailLeftMyGradeView: UIView {

    var model:ModelCourseDtail?{
        didSet{
            self.labScore.text = model?.credit.count == 0 ? "-" : model!.credit
            self.labAllPoint.text = model?.completionDegree.count == 0 ? "-" : model!.completionDegree;
            self.labAllScore.text = model?.score.count == 0 ? "-" : model?.score ;
            
            
            //成绩优秀 暂无
            self.labLevel.text = "not found"
            // 已完成时 展示 奖牌成绩
            if model!.status == "3" {
                self.imgLevel.isHidden = false;
                self.labLevel.text = "not found status = 3"
                self.labLevel.adjustsFontSizeToFitWidth = true
            }else
            {
                self.labLevel.text = "";
                self.imgLevel.isHidden = true;
            }
        }
    }
    
    var blockClickStruct: BaseBlockSuccess?
    @IBOutlet weak var labLevel: UILabel!
    @IBOutlet weak var imgLevel: UIImageView!
    
    @IBOutlet weak var labAllScore: UILabel!
    @IBOutlet weak var labAllPoint: UILabel!
    @IBOutlet weak var labScore: UILabel!
    @IBOutlet weak var viewCon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
//        CommonTool.addCornerRadius_fast(sizeW: SCREEN_WIDTH - 30, sizeH: 145, layer: self.viewCon.layer, radius: 5, arr: .allCorners)
        
        
    } 
    @IBAction func btnActionStruct(_ sender: Any) {
        if let _ = blockClickStruct{
            blockClickStruct!()
        }
    }
}
