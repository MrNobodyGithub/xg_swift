//
//  CourseTaskDetailHeaderView.swift
//  xueguo
//
//  Created by CityMedia on 2019/9/8.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseTaskDetailHeaderView: UITableViewHeaderFooterView {
    // w : sw -( 16 + 16 + 15 + 8)
    // font 14
    // h : 212 - 63 
    
    //--------------------- in -------------------------------
    var height:CGFloat?{
        didSet{
            CommonTool.addCornerRadius(size: CGSize.init(width: SCREEN_WIDTH - 32, height: height!), layer: self.viewCon.layer, cornerSize: CGSize.init(width: 10, height: 10), arr: UIRectCorner.allCorners)
        }
    }
    var model:ModelTaskDetail?{
        didSet{
            let modelClass = model!.cloEvaluate
            let count = model!.evaluateItemList.count
            
            self.labTitle.text = modelClass.taskName
            self.labDetail.text = modelClass.taskContent
            self.labNumber.text = "共\(count)个"
            
        }
    }
    //--------------------- pro -------------------------------
    
    @IBOutlet weak var labTitle: UILabel!
    
    @IBOutlet weak var labNumber: UILabel!
    
    @IBOutlet weak var labDetail: UILabel!
    
    @IBOutlet weak var viewCon: UIView!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        baseConfiguration()
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        let v :UIView = Bundle.init(for: CourseTaskDetailHeaderView.self).loadNibNamed("CourseTaskDetailHeaderView", owner: self, options: nil)?.first as! UIView
        v.frame = self.bounds
        v.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(v)
        
        
        
    }
    


}
