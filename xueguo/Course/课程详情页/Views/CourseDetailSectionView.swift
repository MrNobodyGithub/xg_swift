//
//  CourseDetailSectionView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailSectionView: UIView {

    var blockClick:BaseBlockSuccess?
    @IBOutlet weak var btnFailExamRule: UIButton!
    @IBOutlet weak var labTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        btnFailExamRule.isHidden = true
    }
    func setupViews(){
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        
    }
    @IBAction func btnActionFailExamRule(_ sender: Any) {
        if let _ = blockClick{
            blockClick!()
        }
    }
}
