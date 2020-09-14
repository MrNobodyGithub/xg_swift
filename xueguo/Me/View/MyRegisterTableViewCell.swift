//
//  MyRegisterTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MyRegisterTableViewCell: UITableViewCell {

    var model:ModelJobList?{
        didSet{
            self.labTitle.text = model!.companyName
            self.labTime.text = "就职时间:" + model!.createTime
            self.labPosition.text = model?.position
            self.labIndustry.text = model!.industry
        }
    }
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labPosition: UILabel!
    @IBOutlet weak var labIndustry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration() 
    }
    func baseConfiguration() -> Void {
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
}
