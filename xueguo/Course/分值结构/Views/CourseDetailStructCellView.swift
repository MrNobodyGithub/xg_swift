//
//  CourseDetailStructCellView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/31.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailStructCellView: UIView {

    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var labDown: UILabel!
    @IBOutlet weak var labMid: UILabel!
    @IBOutlet weak var labTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "ffffff")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        
    }

}
