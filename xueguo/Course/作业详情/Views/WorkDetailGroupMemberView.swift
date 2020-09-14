//
//  WorkDetailGroupMemberView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/18.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class WorkDetailGroupMemberView: UIView {
    

    @IBOutlet weak var labLeader: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    func loadNib(){
        let v :UIView = Bundle.init(for: WorkDetailGroupMemberView.self).loadNibNamed("WorkDetailGroupMemberView", owner: self, options: nil)?.first as! UIView
        v.frame = self.bounds
        v.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(v)
        
        
        self.labLeader.layer.cornerRadius = 6.5;
        self.labLeader.layer.masksToBounds = true;
    
        self.labLeader.layer.shadowColor = UIColor.colorWithHex(hexStr: "#7AB5FA").cgColor
        self.labLeader.layer.shadowOffset = CGSize.init(width: 2, height: 2)
        self.labLeader.layer.shadowRadius = 4
        
    }

}
