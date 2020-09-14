//
//  QATopView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QATopView: UIView {
 
    
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var textFieldSearch: UITextField!
//    var blcokText:BaseBlock_T<Any>?
    var blockText:BaseBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
        textFieldSearch.delegate = self
        let h : CGFloat = 133
    
        CommonTool.addGradientColo(self.viewCon.layer, CGSize.init(width: SCREEN_WIDTH, height: h), ["#93DE8A","#54C77A"])
    }
    func setupViews(){
        
    }
   
}
extension QATopView:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        let str = textField.text
        if str!.count > 0 {
            if let  _ = blockText{
                blockText!(str!)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
