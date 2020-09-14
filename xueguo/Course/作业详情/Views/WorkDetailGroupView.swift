//
//  WorkDetailGroupView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/18.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit



class WorkDetailGroupView: UIView {
    
    var blockEvaluate:BaseBlockSuccess?
    var blockOtherGroup:BaseBlockSuccess?
    
    @IBOutlet weak var viewCon: UIView!
    
    @IBOutlet weak var btnInterval: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        CommonTool.addGradientColo(self.btnInterval.layer, CGSize.init(width: SCREEN_WIDTH - 40, height: 38), ["#99CCFC","#5797F7"])
        
    }
    func setupViews(){
//        WorkDetailGroupMemberView
        let w:CGFloat = 70
        let h:CGFloat = 75
//        let v1 = WorkDetailGroupMemberView.init(frame: CGRect.init(x: 10, y: 0, width: w, height: h))
//        self.viewCon.addSubview(v1)
//
        
        var x:CGFloat = 0
        for index:Int in 0...2 {
            x =  CGFloat(index) * w
            let v1 = WorkDetailGroupMemberView.init(frame: CGRect.init(x: 10 + x, y: 0, width: w, height: h))
            self.viewCon.addSubview(v1)
        }
    }
    
    
    @IBAction func btnActionOtherGroup(_ sender: Any) {
        if let  _ = blockOtherGroup{
            blockOtherGroup!()
        }
    }
    @IBAction func btnActionEvaluate(_ sender: Any) {
        if let _ = blockEvaluate{
            blockEvaluate!()
        }
    }
    

}
