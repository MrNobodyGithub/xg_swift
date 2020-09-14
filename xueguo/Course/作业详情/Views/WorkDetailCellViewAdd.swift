//
//  WorkDetailCellViewAdd.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
protocol WorkDetailCellViewAddDelegate :NSObjectProtocol{
    func WorkDetailCellViewAddDelegateTap()
}

class WorkDetailCellViewAdd: UIView {

    var delegate:WorkDetailCellViewAddDelegate?
    @IBOutlet weak var viewCon: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    func loadNib(){
        let v :UIView = Bundle.init(for: WorkDetailCellViewAdd.self).loadNibNamed("WorkDetailCellViewAdd", owner: self, options: nil)?.first as! UIView
        v.frame = self.bounds
        v.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(v)
        
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        CommonTool.addShadowCorner(self.viewCon.layer)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.viewCon.addGestureRecognizer(tap)
    }
    func setupViews(){
        
    }
    @objc func tapAction(){
        if (delegate != nil) && delegate?.responds(to: Selector(("WorkDetailCellViewAddDelegateTap"))) != nil {
            delegate?.WorkDetailCellViewAddDelegateTap()
        }
        
        
    }

}
