//
//  MeTopView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

@objc protocol MeTopViewDelegate: NSObjectProtocol {
    @objc optional func MeTopViewDelegatePhoto()
    func MeTopViewDelegateShare()
}

class MeTopView: UIView {

    var delegate : MeTopViewDelegate?
    
    func reloadData(){
        let model:ModelUser = CommonTool.unarhiveUserData()
        self.labName.text = model.studentName
        self.labDetail1.text = model.collegeName + "  " + "院系:" + model.academyName
        
        var time = model.enrolmentTime
        if time != nil && time.count > 4 {
            time = String(time.prefix(4))
        }
        
        self.labDetail2.text = model.majorName + " " + time + "级" + " " + model.classNo + "班"
        if model.sex == "1" {
            self.imgUser.image = UIImage.init(named: "sex_man")
        }else{
            self.imgUser.image = UIImage.init(named: "sex_female")
        }
    }
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labDetail1: UILabel!
    @IBOutlet weak var labDetail2: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(gesTap))
        self.imgUser.addGestureRecognizer(tap)
        imgUser.isUserInteractionEnabled = true

    }

    @objc func gesTap(){
        
        if (delegate != nil) && delegate?.responds(to: Selector(("MeTopViewDelegatePhoto"))) != nil {
            delegate?.MeTopViewDelegatePhoto?()
        }
        
    }
    @IBAction func btnActionShare(_ sender: Any) {
        if (delegate != nil) && delegate?.responds(to: Selector(("MeTopViewDelegateShare"))) != nil {
            delegate?.MeTopViewDelegateShare()
        }
        
    }
}
