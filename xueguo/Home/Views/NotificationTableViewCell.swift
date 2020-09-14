//
//  NotificationTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    var model:ModelNotification?{
        didSet{
            self.labTitle.text = model!.noticeTitle
            self.labDetail.text = model!.noticeContent
            self.labTime.text = model!.readTime
        }
    }
    
    @IBOutlet weak var imgNotifi: UIImageView!
    
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labDetail: UILabel!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
}
