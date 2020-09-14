//
//  OtherGroupSubView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class OtherGroupSubView: UIView {

    
    @IBOutlet weak var viewCon: UIView!
   
    
    func addMemberWith(num:NSInteger){
//        WorkDetailGroupMemberView;
        let w :CGFloat = (SCREEN_WIDTH - (15 + 15 + 70)) / 4
        let h: CGFloat =  78 // 58
        var y: CGFloat = 135 / 2 - h / 2
        var x: CGFloat = 0
        
        for index in 0..<num {
            x = CGFloat(index%4) * w
            
            y =  CGFloat(index/4) * h + 135 / 2 - h / 2
            
            let v : WorkDetailGroupMemberView = WorkDetailGroupMemberView.init(frame: CGRect.init(x: x, y: y, width: w, height: h))
            self.viewCon.addSubview(v)
        }
        
    }
    
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
}
