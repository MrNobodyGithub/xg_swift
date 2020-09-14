//
//  CourseDetailTopView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailTopView: UIView {

    @IBOutlet weak var viewRedPoint: UIView!
    
    @IBOutlet weak var viewFlag: UIView!
    @IBOutlet weak var viewL: UIView!
    @IBOutlet weak var viewM: UIView!
    @IBOutlet weak var viewR: UIView!
    
    @IBOutlet weak var btnL: UIButton!
    @IBOutlet weak var btnM: UIButton!
    @IBOutlet weak var btnR: UIButton!
    
    var blockIndex: BaseBlock_T<Int>? // 传递 点击 触发滚动视图联动
    var selIndex:Int?{
        didSet{
            if selIndex == 0{
                self.btnActionLeft(self.btnL)
            }else if selIndex == 1{
                self.btnActionMid(self.btnM)
            }else if selIndex == 2{
                self.btnActionRight(self.btnR)
            }
        }
    }
    
    var flagBtn: UIButton?
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
        flagBtn = self.btnL
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        
    }
    
    @IBAction func btnActionLeft(_ sender: UIButton) {
        if let _ = blockIndex{
            blockIndex!(0)
        }
        btnAction(btn: sender)
        UIView.animate(withDuration: 0.3) {
            self.viewFlag.center = CGPoint.init(x:self.viewL.center.x , y: self.viewFlag.center.y)
        }
    }
    @IBAction func btnActionMid(_ sender: UIButton) {
        if let _ = blockIndex{
            blockIndex!(1)
        }
        btnAction(btn: sender)
        UIView.animate(withDuration: 0.3) {
            self.viewFlag.center = CGPoint.init(x:self.viewM.center.x , y: self.viewFlag.center.y)
        }
    }
    @IBAction func btnActionRight(_ sender: UIButton) {
        if let _ = blockIndex{
            blockIndex!(2)
        }
        btnAction(btn: sender)
        UIView.animate(withDuration: 0.3) {
            self.viewFlag.center = CGPoint.init(x:self.viewR.center.x , y: self.viewFlag.center.y)
        }
    }
    
    
    func btnAction(btn:UIButton) {
        if btn == flagBtn {
            return
        }
        let color:UIColor = UIColor.colorWithHex(hexStr: "#9B9B9B")
        let colorSel:UIColor = UIColor.colorWithHex(hexStr: "#484848")
        
        flagBtn?.setTitleColor(color, for: .normal)
        btn.setTitleColor(colorSel, for: .normal)
        
//        let  attributeString:NSMutableAttributedString = btn.currentAttributedTitle as! NSMutableAttributedString
//        attributeString.addAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key:colorSel], range: NSRange.init(location: 0, length: attributeString.length))
//        btn.setAttributedTitle(attributeString, for: .normal)
//
//
//        let  attributeStringFlag:NSMutableAttributedString = flagBtn?.currentAttributedTitle as! NSMutableAttributedString
//        attributeStringFlag.addAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key:color], range: NSRange.init(location: 0, length: attributeStringFlag.length))
//        flagBtn!.setAttributedTitle(attributeStringFlag, for: .normal)
//
        flagBtn = btn
    }
    
    

}
