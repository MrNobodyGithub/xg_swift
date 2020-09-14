//
//  HonorNavView.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/13.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HonorNavView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var layoutDown: NSLayoutConstraint!
    
    var blockBack: BaseBlockSuccess?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        self.backgroundColor = .white
    }
    func setupViews(){
        
    }
    @IBAction func btnActionBack(_ sender: Any) {
        if let _ = blockBack {
            blockBack!()
        }
    }
    
}
