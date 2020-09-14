//
//  SearchHistoryView.swift
//  xueguo
//
//  Created by CityMedia on 2019/9/9.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class SearchHistoryView: UIView {
    
    //--------------------- in -------------------------------
    //--------------------- pro -------------------------------
    
    @IBOutlet weak var viewCon: UIView!
    
    var arrHistory:[String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    
    //MARK: --------------------views-------------------
    func setupViews(){
        let arr:[String] = UserDefaults.standard.array(forKey: DefKeySearchKey) as! [String]
        if arr.count == 0 {
        }else{
            arrHistory = arr
            
        }
        self.setupHotKeyView()
    }
    func setupHotKeyView(){
        
        let h:CGFloat = 20
//        var w:CGFloat = 0
        var difW:CGFloat = 8
        let font:UIFont = UIFont.systemFont(ofSize: 12)
        let color:UIColor = UIColor.colorWithHex(hexStr: "#9B9B9B")
        
        
        
        var x:CGFloat = 16
        var y:CGFloat = 0
        
        for (index,str) in arrHistory.enumerated() {
            let truew = CommonTool.getStrWidth(str: str, fontsize: 12, height: h) + 18
          
//            x += truew + difW
            if x + truew + difW > SCREEN_WIDTH {
                x = 16
                y += h + 10
            }
            let btn = ZUIButton.init(frame: CGRect.init(x: x, y: y, width: truew, height: h))
            x += truew + difW
            btn.setTitle(str, for: .normal)
            btn.titleLabel?.font = font
            btn.backgroundColor = UIColor.colorWithHex(hexStr: "#EEEEEE")
            btn.setTitleColor(color, for: .normal)
            btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
            btn.cusIndex = index
            self.viewCon.addSubview(btn)
            
        }
    }
    
    //MARK: --------------------action-------------------
    @IBAction func btnActionDel(_ sender: Any) {
    }
    
    @objc func btnAction(btn:ZUIButton){
        let index = btn.cusIndex
        let text = self.arrHistory[index]
        print(text)
        
    }

}
