//
//  MeView_a.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

protocol MeView_aDelegate:NSObjectProtocol {
    func MeView_aDelegateSetting()
    func MeView_aDelegateColl()
    func MeView_aDelegateRegister()
    func MeView_aDelegateHononer()
}

class MeView_a: UIView {
    var delegate:MeView_aDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func btnActionSetting(_ sender: UIButton) {
        if (delegate != nil) && delegate?.responds(to: Selector(("MeView_aDelegateSetting"))) != nil {
            delegate?.MeView_aDelegateSetting()
        }
        
    }
    @IBAction func btnActionColl(_ sender: UIButton) {
        if (delegate != nil) && delegate?.responds(to: Selector(("MeView_aDelegateColl"))) != nil {
            delegate?.MeView_aDelegateColl()
        }
        
    }
    @IBAction func btnActionRegister(_ sender: UIButton) {
        if (delegate != nil) && delegate?.responds(to: Selector(("MeView_aDelegateRegister"))) != nil {
            delegate?.MeView_aDelegateRegister()
        }
        
    }
    
    @IBAction func btnActionHononer(_ sender: Any) {
        if (delegate != nil) && delegate?.responds(to: Selector(("MeView_aDelegateHononer"))) != nil {
            delegate?.MeView_aDelegateHononer()
        }
        
    }
}
