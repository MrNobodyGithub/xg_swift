//
//  HomeTopView.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/25.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit
import SDCycleScrollView
enum HomeTopViewType {
    case colleage
    case schedule
    case file
}

protocol HomeTopViewDelegate :NSObjectProtocol{
    func HomeTopViewDelegateCycleSelect(_: Int)
    func HomeTopViewDelegateCycleScroll(_: Int)
    func HomeTopViewDelegateType(_ type: HomeTopViewType)
}

class HomeTopView: UIView  {
   
    //MARK: ----property---------------------
    var delegate:HomeTopViewDelegate?
    
//    var dataArr:[ModelBanner]?{
//        didSet{
//            let imgArr = dataArr?.map{
//                return $0.linkImage
//            }
//            self.cycleView?.imageURLStringsGroup = imgArr
//        }
//    }
    //MARK:----private---------------------
    
    //MARK:----IBOutlet---------------------
    
    @IBOutlet weak var viewCycle: UIView!
    var cycleView: SDCycleScrollView?
    override func awakeFromNib() {
        super.awakeFromNib() 
        let cycleView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH-34, height: TRANS_GET_H(w: SCREEN_WIDTH-34, scale: 342.0/167.0)))
        cycleView.delegate = self
        let path = Bundle.main.path(forResource: "tmp2.png", ofType: nil)
        cycleView.localizationImageNamesGroup = [path!,path!]
        viewCycle.addSubview(cycleView)
        cycleView.autoScrollTimeInterval = 5.0
        self.cycleView = cycleView;
         
    }
    @objc func btnActionSearch(){ 
        
    }
    @IBAction func btnActionNotification(_ sender: Any) {
 
    }
    
    @IBAction func btnActionCollege(_ sender: Any) {
        if (delegate != nil) && delegate?.responds(to: Selector(("HomeTopViewDelegateType"))) != nil {
            delegate?.HomeTopViewDelegateType(.colleage)
        }
        
    }
    
   
    
    @IBAction func btnActionFile(_ sender: Any) {
        if (delegate != nil) && delegate?.responds(to: Selector(("HomeTopViewDelegateType"))) != nil {
            delegate?.HomeTopViewDelegateType(.file)
        }
    }
    
    
    
}

extension HomeTopView:SDCycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        if (delegate != nil) && delegate?.responds(to: Selector(("HomeTopViewDelegateCycleSelect"))) != nil {
             delegate?.HomeTopViewDelegateCycleSelect(index)
        }
    }
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        if (delegate != nil) && delegate?.responds(to: Selector(("HomeTopViewDelegateCycleScroll"))) != nil {
            delegate?.HomeTopViewDelegateCycleScroll(index)
        }
    }
}
