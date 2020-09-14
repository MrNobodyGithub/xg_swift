//
//  QAAnsTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QAAnsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labText: UILabel!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    //    let w: CGFloat = SCREEN_WIDTH - 16 * 2 - 73 - 13
//    let h: CGFloat = 60 + 50
    // if h > 50 -> 60 + true else 110
    
    
  
    var model:ModelQaAnswer? {
        didSet{
            self.labTime.text = model?.createTime
            if (model?.updateTime.count)! > 0 {
                self.labTime.text = model?.updateTime
            }
            self.labText.text = model?.answer
            self.labName.text = model?.teacherName
        }
    }
    var conH :CGFloat? {
        didSet{
            self.viewCon.layer.cornerRadius = 5
            self.viewCon.layer.masksToBounds = true
//            CommonTool.addCornerRadius(size: CGSize.init(width: SCREEN_WIDTH - 32, height: conH!), layer: self.viewCon.layer, cornerSize: CGSize.init(width: 5, height: 5), arr: UIRectCorner.allCorners)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
          CommonTool.addCornerRadius(size: CGSize.init(width: SCREEN_WIDTH - 32, height: 90), layer: self.viewCon.layer, cornerSize: CGSize.init(width: 5, height: 5), arr: UIRectCorner.allCorners)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
}
