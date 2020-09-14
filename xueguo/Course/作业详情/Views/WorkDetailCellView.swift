//
//  WorkDetailCellView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

protocol WorkDetailCellViewDelegate:NSObjectProtocol {
    func WorkDetailCellViewDelegateDelete(m:NSObject);
}

class WorkDetailCellView: UIView {

    var delegate:WorkDetailCellViewDelegate?
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var imgIcon: UIView!
    
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
        let v :UIView = Bundle.init(for: WorkDetailCellView.self).loadNibNamed("WorkDetailCellView", owner: self, options: nil)?.first as! UIView
        v.frame = self.bounds
        v.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(v)
        
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        CommonTool.addShadowCorner(self.viewCon.layer)
    }
    
    @IBAction func btnActionDelete(_ sender: UIButton) {
        if (delegate != nil) && delegate?.responds(to: Selector(("WorkDetailCellViewDelegateDelete(:)"))) != nil {
            delegate?.WorkDetailCellViewDelegateDelete(m: NSObject.init())
        }
        
    }
    
}
