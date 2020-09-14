//
//  MyHonorTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/15.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MyHonorTableViewCell: UITableViewCell {

    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    
    @IBOutlet weak var labImgType: UILabel!
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labDetail: UILabel!
   
 
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
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
}
