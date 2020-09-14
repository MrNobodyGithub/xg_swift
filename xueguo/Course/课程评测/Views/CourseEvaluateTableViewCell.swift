//
//  CourseEvaluateTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/4.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseEvaluateTableViewCell: UITableViewCell {
    //w  30 + 38 + 25 + div
    //h 16 + div   min 13 + 16
    
    //
    var isLast:Bool?{
        didSet{
            if isLast! {
                CommonTool.addCornerRadius_fast(sizeW: SCREEN_WIDTH - 30, sizeH: 87, layer: self.viewCon.layer, radius: 10, arr: [UIRectCorner.bottomRight,UIRectCorner.bottomLeft])
            }
        }
    }
    @IBOutlet weak var viewCon: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib() 
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    
}
