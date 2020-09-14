//
//  QAMidView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

enum QAMidViewType{
    case def 
    case all
    case ed
    case not
    case accept
}



class QAMidView: UIView {
 
    var blockType : BaseBlock_T<QAMidViewType>?
    
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var btnNot: UIButton!
    @IBOutlet weak var btnEd: UIButton!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    var selBtn: UIButton?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
        
    }
    func baseConfiguration() -> Void {
        selBtn = self.btnAll
        
    }
    func setupViews(){
        
    }
    
    let fontSmall = UIFont.systemFont(ofSize: 15)
    let fontBig = UIFont.systemFont(ofSize: 18)
    let colorSel = UIColor.black
    let colorUnSel = UIColor.colorWithHex(hexStr: "#484848")
    @IBAction func btnActionAll(_ sender: UIButton) {
        btnAction(sender)
        if let _ = self.blockType   {
            self.blockType!(QAMidViewType.all)
        }
    }
    
    @IBAction func btnActionEd(_ sender: UIButton) {
        btnAction(sender)
        if let _ = self.blockType{
            blockType!(QAMidViewType.ed)
        }
    }
    
    @IBAction func btnActionNot(_ sender: UIButton) {
        btnAction(sender)
        if let _ = self.blockType{
            blockType!(QAMidViewType.not)
        }
    }
    @IBAction func btnActionAccept(_ sender: UIButton) {
        btnAction(sender)
        if let _ = self.blockType{
            blockType!(QAMidViewType.accept)
        }
    }
    
    func btnAction(_ sender:UIButton){
        if selBtn == sender{
        }else
        {
            UIView.animate(withDuration: 0.618) {
                self.selBtn?.titleLabel?.font = self.fontSmall
                self.selBtn?.setTitleColor(self.colorUnSel, for: .normal)
                
                sender.titleLabel?.font = self.fontBig
                sender.setTitleColor(self.colorSel, for: .normal)
                
                
                let y = self.imgFlag.center.y
                self.imgFlag.center = CGPoint.init(x: sender.center.x, y: y)
            }
            self.selBtn = sender
        }
    }

}
