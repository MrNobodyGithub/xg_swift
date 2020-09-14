//
//  HomeTopSearchView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
protocol HomeTopSearchViewDelegate :NSObjectProtocol{ 
    func HomeTopSearchViewDelegateNotification()
    func HomeTopSearchViewDelegateSearch()
}

class HomeTopSearchView: UIView {
    func reloadData(){
        let m : ModelUser = CommonTool.unarhiveUserData()
        self.labUniversityName.text = m.collegeName
    }
    var delegate:HomeTopSearchViewDelegate?
    func settingBtnRed(isRed:Bool) {
        if isRed {
             self.btnNotification.setImage(UIImage.init(named: "notifacation_red"), for: .normal)
        }else{
            self.btnNotification.setImage(UIImage.init(named: "notifacation"), for: .normal)
        }
    }
    //MARK:------------------IBOutlet---------------------
    @IBOutlet weak var viewSearch: UIView! 
    @IBOutlet weak var labUniversityName: UILabel!
    @IBOutlet weak var imgUniversity: UIImageView!
    
    @IBOutlet weak var btnNotification: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(btnActionSearch))
        viewSearch.addGestureRecognizer(tap)
        let m : ModelUser = CommonTool.unarhiveUserData()
        self.labUniversityName.text = m.collegeName
        
     }
   
    @objc func btnActionSearch() {
        if (delegate != nil) && delegate?.responds(to: Selector(("HomeTopViewDelegateSearch"))) != nil {
            delegate?.HomeTopSearchViewDelegateSearch()
        } 
    }

    @IBAction func btnActionNotification(_ sender: UIButton) {
        if (delegate != nil) && delegate?.responds(to: Selector(("HomeTopSearchViewDelegateNotification"))) != nil {
            delegate?.HomeTopSearchViewDelegateNotification()
        } 
    }
}
