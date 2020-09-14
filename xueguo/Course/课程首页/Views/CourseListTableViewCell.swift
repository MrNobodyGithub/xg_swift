//
//  CourseListTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseListTableViewCell: UITableViewCell {

    var blockClick:BaseBlockSuccess?
    var model:ModelCourseList?{
        didSet{
            self.labTitle.text = model?.courseName
            self.labDetail.text = model?.courseCate
        }
    }
    @IBOutlet weak var viewCon: UIView!
    
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var labNumber: UILabel! //限制：100人 已报名：59人
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        CommonTool.addShadowCorner(self.viewCon.layer)
//        let arc = arc4random() % 2
//        self.btnApply.isHidden = arc == 0
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionApply(_ sender: Any) {
        
        if let _ = blockClick {
            blockClick!()
        }
    }
}
