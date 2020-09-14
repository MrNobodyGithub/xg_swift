//
//  CourseMidView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
enum CourseMidViewType{
    case def
    case all
    case ing
    case open
    case finish
}

class CourseMidView: UIView {
    var selBtn:UIButton?
//    @IBOutlet weak var imgFlag: UIImageView!
    
    var blockType : BaseBlock_T<CourseMidViewType>?
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var btnAll: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
    }
    func setupViews(){
        selBtn = self.btnAll
    }
 
    @IBAction func btnActionAll(_ sender: UIButton) {
        btnAction(sender)
        if let _ = blockType {
            blockType!(.all)
        }
    }
    
    @IBAction func btnActionIng(_ sender: UIButton) {
        btnAction(sender)
        if let _ = blockType {
            blockType!(.ing)
        }
    }
    
    @IBAction func btnActionOpen(_ sender: UIButton) {
        btnAction(sender)
        if let _ = blockType {
            blockType!(.open)
        }
    }
    
    @IBAction func btnActionFinish(_ sender: UIButton) {
        btnAction(sender)
        if let _ = blockType {
            blockType!(.finish)
        }
    }
    
    
    let fontSmall = UIFont.systemFont(ofSize: 15)
    let fontBig = UIFont.systemFont(ofSize: 18)
    let colorSel = UIColor.black
    let colorUnSel = UIColor.colorWithHex(hexStr: "#484848")
    func btnAction(_ sender:UIButton){
        if selBtn == sender{
        }else
        {
            UIView.animate(withDuration: 0.618) {
                self.selBtn?.titleLabel?.font = self.fontSmall
                self.selBtn?.setTitleColor(self.colorUnSel, for: .normal)
                
                sender.titleLabel?.font = self.fontBig
                sender.setTitleColor(self.colorSel, for: .normal)
                
                
               
                let defW:CGFloat =  18
                let count: Int = (sender.titleLabel?.text!.count)!
                self.imgFlag.frame.size = CGSize.init(width: CGFloat(count) * defW, height: 7)
                let y = self.imgFlag.center.y
                self.imgFlag.center = CGPoint.init(x: sender.center.x, y: y)
            }
            self.selBtn = sender
        }
    }
}
