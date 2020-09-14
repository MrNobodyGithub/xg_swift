
//
//  HonorUploadSuccessView.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/20.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HonorUploadSuccessView: UIView {

    var blockBack:BaseBlockSuccess?
    
    @IBOutlet weak var btnBack: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        self.btnBack.layer.cornerRadius = 11.5;
        self.btnBack.layer.masksToBounds = true;
        CommonTool.addGradientColo(self.btnBack.layer, self.btnBack.frame.size, ["#99CCFC","#5898F7"])
    }
    func setupViews(){
        
    }

    @IBAction func btnActionBack(_ sender: Any) {
        if let _ = self.blockBack {
            self.blockBack!()
        }
    }
}
